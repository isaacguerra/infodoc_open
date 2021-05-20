require 'colorize'
require 'csv'
require 'date'
require 'json'
require 'optparse'
require 'ostruct'
require 'rest-client'

DEFAULT_PATH = 'monthly-report.csv'

def get_duration_hrs_and_mins(duration)
  minutes = (duration / (1000 * 60) % 60).ceil
  hours = (duration / (1000 * 60 * 60)).floor
  return "#{minutes} minuto#{minutes > 1 ? 's' : ''}" unless hours > 0
  return "#{hours} hora#{hours > 1 ? 's' : ''}" unless minutes > 0

  "#{hours} hora#{hours > 1 ? 's' : ''} e #{minutes} minuto#{minutes > 1 ? 's' : ''}" 
end

def get_data()
  raise 'Clickup api Token argument missing' if !OPTIONS.token

  current_year = DateTime.now.year
  current_month = DateTime.now.month

  year = OPTIONS.year&.to_i || current_year

  ending_month = OPTIONS.ending_month&.to_i || current_month
  initial_month = OPTIONS.initial_month&.to_i || current_month - 1

  if initial_month > 12 || ending_month > 12
    raise 'Invalid Month'
  elsif initial_month < 1 || ending_month < 1
    raise 'Invalid Month'
  end

  start_date = DateTime
    .new(
      (ending_month == 1) ? year - 1 : year,
      (ending_month == 1) ? 12 : initial_month,
      18, 0, 0, 0, '+3'
    )
  
  end_date = DateTime
    .new(
      (initial_month == 12) ? year + 1 : year,
      (initial_month == 12) ? 1 : ending_month,
      18, 23, 59, 59, '+3'
    )

  if start_date > end_date
    raise 'Initial Month is After Ending Month'
  end

  puts "18/#{start_date.month}/#{start_date.year} até 18/#{end_date.month}/#{end_date.year}"

  puts 'Carregando dados...'.yellow

  response = RestClient.get(
    "https://api.clickup.com/api/v2/team/8402123/time_entries?start_date=#{start_date.strftime('%Q')}&end_date=#{end_date.strftime('%Q')}",
    {
      authorization: OPTIONS.token, 
      content_type: 'application/json'
    }
  )

  raise 'Erro ao Caregar Dados' unless response.code == 200

  JSON.parse(response.body)['data']
end

def handled_data
  handled_data = get_data.map do |obj|
    {
      id: obj['task']['id'],
      time: obj['duration'],
      title: obj['task']['name']
    }
  end

  grouped = handled_data.group_by { |item| { id: item[:id], title: item[:title] } }

  grouped.map do |task, times|
    time_sum = times.sum(0) { |e| e[:time].to_i }
    {
      url: "https://app.clickup.com/t/#{task[:id].to_s}",
      title: task[:title],
      time: time_sum,
      humanized_time: get_duration_hrs_and_mins(time_sum)
    }
  end
end

def perform
  tasks = handled_data
  total_time = tasks.sum(0) { |e| e[:time] }

  puts 'Gerando Planilha...'.blue

  File.open(OPTIONS.path || DEFAULT_PATH, 'w') do |file|
    sheets = CSV.generate(col_sep: ';') do |csv|
      csv << [
        'Card',
        'Tarefa',
        'Horas'
      ]

      tasks.each do |task|
        csv << [
          task[:url],
          task[:title],
          task[:humanized_time]
        ]
      end

      csv << [
        'Total',
        '',
        get_duration_hrs_and_mins(total_time)
      ]
    end

    file << sheets
  end

  puts 'Gerado com Sucesso!'.green.blink
end

OPTIONS = OpenStruct.new
OptionParser.new do |opt|
  opt.on('-t',
    '--token <your clickup api token>',
    'Clickup API token'
  ) { |o| OPTIONS.token = o }

  opt.on('-f',
    '--file-path <the file path to be genetared>',
    'Example: ~/Documents/monthly_report.csv'
  ) { |o| OPTIONS.path = o }

  opt.on('-i',
    '--initial-month <1 until 12>',
    'The month of the range start (appolus consider 18th day of month as start and end day)'
  ) { |o| OPTIONS.initial_month = o }

  opt.on('-e',
    '--ending-month <1 until 12>',
    'The month of the range ending (appolus consider 18th day of month as start and end day)'
  ) { |o| OPTIONS.ending_month = o }

  opt.on('-y',
    '--year <Report year>',
    'The Year of Report Period'
  ) { |o| OPTIONS.year = o }
end.parse!

perform
