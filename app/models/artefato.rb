class Artefato < ActiveRecord::Base
  belongs_to :entidade
  belongs_to :cadastro

  #file_column :objeto_file_name, :store_dir => "uploadartefatos/"
  has_attached_file :objeto, :path => ":rails_root/uploadartefatos/system/:class/:attachment/:id/:style/:basename.:extension"

  validates_presence_of :cadastro_id
  validates_presence_of :entidade_id

  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}

  def fazer_ocr
    file = ""
    file_ocr = ""

    size = self.objeto.path.size
    if self.objeto_content_type == "image/tiff"
      file = self.objeto.path
      file_ocr = "#{self.objeto.path[0..size-5]}"
    elsif self.objeto_content_type == "image/gif" or self.objeto_content_type == "image/bmp" or self.objeto_content_type == "image/jpg" or self.objeto_content_type == "image/png" or self.objeto_content_type == "image/bmp" or self.objeto_content_type == "image/jpeg"
      file_origem = self.objeto.path
      file_ocr = "#{self.objeto.path[0..size-5]}"
      file = "#{self.objeto.path[0...size-3]}tif"
      system "convert #{file_origem} #{file}"
    end

    unless file_ocr == ""
      if system "tesseract #{file} #{file_ocr} -l por"
        f = File.open("#{file_ocr}.txt", 'r')
        self.ocr = f.read
        self.save
      end
    end
  end

  def mime_type
    case self.objeto_content_type
      when 'application/msword'
        return 'documento'
      when 'application/vnd.ms-word.document.macroEnabled.12'
        return 'documento'
      when 'application/vnd.oasis.opendocument.text'
        return 'documento'
      when 'application/vnd.oasis.opendocument.text-template'
        return 'documento'
      when 'application/vnd.oasis.opendocument.text-master'
        return 'documento'
      when 'application/vnd.oasis.opendocument.text-web'
        return 'documento'
      when 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
        return 'documento'
      when 'application/vnd.stardivision.writer'
        return 'documento'
      when 'application/vnd.sun.xml.writer'
        return 'documento'
      when 'application/vnd.sun.xml.writer.template'
        return 'documento'
      when 'application/vnd.sun.xml.writer.global'
        return 'documento'
      when 'application/vnd.wordperfect'
        return 'documento'
      when 'application/x-abiword'
        return 'documento'
      when 'application/x-applix-word'
        return 'documento'
      when 'application/x-kword'
        return 'documento'
      when 'application/x-kword-crypt'
        return 'documento'


      when 'application/vnd.ms-excel'
        return 'planilha'
      when 'application/vnd.ms-excel.sheet.macroEnabled.12'
        return 'planilha'
      when 'application/vnd.oasis.opendocument.spreadsheet'
        return 'planilha'
      when 'application/vnd.oasis.opendocument.spreadsheet-template'
        return 'planilha'
      when 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        return 'planilha'
      when 'application/vnd.stardivision.calc'
        return 'planilha'
      when 'application/vnd.sun.xml.calc'
        return 'planilha'
      when 'application/vnd.sun.xml.calc.template'
        return 'planilha'
      when 'application/vnd.lotus-1-2-3'
        return 'planilha'
      when 'application/x-applix-spreadsheet'
        return 'planilha'
      when 'application/x-gnumeric'
        return 'planilha'
      when 'application/x-kspread'
        return 'planilha'
      when 'application/x-kspread-crypt'
        return 'planilha'


      when 'application/vnd.ms-powerpoint'
        return 'apresentacao'
      when 'application/vnd.ms-powerpoint.presentation.macroEnabled.12'
        return 'apresentacao'
      when 'application/vnd.oasis.opendocument.presentation'
        return 'apresentacao'
      when 'application/vnd.oasis.opendocument.presentation-template'
        return 'apresentacao'
      when 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
        return 'apresentacao'
      when 'application/vnd.stardivision.impress'
        return 'apresentacao'
      when 'application/vnd.sun.xml.impress'
        return 'apresentacao'
      when 'application/vnd.sun.xml.impress.template'
        return 'apresentacao'
      when 'application/x-kpresenter'
        return 'apresentacao'


      when 'application/zip'
        return 'compactado'
      when 'application/x-zip'
        return 'compactado'
      when 'application/stuffit'
        return 'compactado'
      when 'application/x-stuffit'
        return 'compactado'
      when 'application/x-7z-compressed'
        return 'compactado'
      when 'application/x-ace'
        return 'compactado'
      when 'application/x-arj'
        return 'compactado'
      when 'application/x-bzip'
        return 'compactado'
      when 'application/x-bzip-compressed-tar'
        return 'compactado'
      when 'application/x-compress'
        return 'compactado'
      when 'application/x-compressed-tar'
        return 'compactado'
      when 'application/x-cpio-compressed'
        return 'compactado'
      when 'application/x-deb'
        return 'compactado'
      when 'application/x-gzip'
        return 'compactado'
      when 'application/x-java-archive'
        return 'compactado'
      when 'application/x-lha'
        return 'compactado'
      when 'application/x-lhz'
        return 'compactado'
      when 'application/x-lzop'
        return 'compactado'
      when 'application/x-rar'
        return 'compactado'
      when 'application/x-rpm'
        return 'compactado'
      when 'application/x-tzo'
        return 'compactado'
      when 'application/x-tar'
        return 'compactado'
      when 'application/x-tarz'
        return 'compactado'
      when 'application/x-tgz'
        return 'compactado'


      when 'application/ecmascript'
        return 'script'
      when 'application/javascript'
        return 'script'
      when 'application/mathematica'
        return 'script'
	    when 'application/psd'
	      return 'script'
      when 'application/vnd.mozilla.xul+xml'
        return 'script'
      when 'application/x-asp'
        return 'script'
      when 'application/x-awk'
        return 'script'
      when 'application/x-cgi'
        return 'script'
      when 'application/x-csh'
        return 'script'
      when 'application/x-m4'
        return 'script'
      when 'application/x-perl'
        return 'script'
      when 'application/x-php'
        return 'script'
      when 'application/x-ruby'
        return 'script'
      when 'application/x-shellscript'
        return 'script'
      when 'text/vnd.wap.wmlscript'
        return 'script'
      when 'text/x-emacs-lisp'
        return 'script'
      when 'text/x-haskell'
        return 'script'
      when 'text/x-literate-haskell'
        return 'script'
      when 'text/x-lua'
        return 'script'
      when 'text/x-makefile'
        return 'script'
      when 'text/x-matlab'
        return 'script'
      when 'text/x-python'
        return 'script'
      when 'text/x-sql'
        return 'script'
      when 'text/x-tcl'
        return 'script'


      when 'application/x-macbinary'
        return 'executavel'
      when 'application/x-ms-dos-executable'
        return 'executavel'
      when 'application/x-pef-executable'
        return 'executavel'


      when 'application/xhtml+xml'
        return 'html'

    when 'application/pdf'
        return 'pdf'

      else
        if self.objeto_content_type.include?("image")
          return 'imagem'
        else
          return 'generico'
        end
    end

  end
end

