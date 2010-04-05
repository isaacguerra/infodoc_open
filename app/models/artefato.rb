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
end

