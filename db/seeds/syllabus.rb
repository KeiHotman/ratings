require 'poppler'

# 学科専攻キーを取得
def get_enum_key(department)
  departments = {
    i: :information,
    e: :electronics,
    m: :mechanical,
    s: :system,
    c: :chemistry,
    aei: :advanced_ei,
    ams: :advanced_ms,
    ac: :advanced_c }

  departments[department.to_sym.downcase]
end

# シラバスパース
def parse(path, attrs = {})
  pdf = Poppler::Document.new(path)
  str = pdf[0].get_text
  elements = str.split("\n")

  def elements.matched(key, regexp, opt = {})
    index = opt[:index] || 0
    range = opt[:range] || (0..self.length)
    matched_element = self[range].find{|element| element =~ regexp}
    matched_element.match(regexp)[index] rescue nil
  end

  # 講義名，講義英語名，単位期間，単位数，単位必修属性
  attrs[:name] = elements[2]
  attrs[:english_name] =
    elements.matched(:english_name, /^[\(（](.+)[）\)]$/, index: 1, range: 0..10)
  attrs[:term] =
    elements.matched(:credit_term, /前期|後期|通年/, range: 1..11)
  attrs[:credit_num] =
    elements.matched(:credit_num, /([0-9０-９]{1,2})\s?(学修)?単位/, index: 1, range: 1..11)
  attrs[:credit_requirement] =
    elements.matched(:credit_requirement, /選択|必修/, range: 1..11)

  # 各特徴
  first_text_column =
    elements.find{|element| element =~ /講[義座]の目[標的]/}
  first_text_column_index =
    elements.index(first_text_column)
  elements_length = elements.length
  title_buffer, body_buffer = '', ''
  attrs[:features_attributes] = []
  elements[first_text_column_index..elements_length].each do |element|
    if key = element.match(/^[\[〔](.+)[\]〕]$/)
      attrs[:features_attributes] <<
        {name: title_buffer, body: body_buffer} if body_buffer.present?
      title_buffer = key[1]
      body_buffer = ''
    else
      body_buffer += "#{element}\n"
    end
  end

  attrs
end

# main
Item.delete_all
syllabuses_path = ENV['syllabus_path']
Dir.entries(syllabuses_path).each do |section|
  next if section =~ /\.{1,2}/
  section_path = File.join(syllabuses_path, section)
  section_year = section.match(/^\d{4}/)[0].to_i
  matched_section_name = section.match(/(\d)([A-Z]{1,3})$/)
  pdfs = Dir.entries(section_path).select{|name| name =~ /^[^(9{3})\D].*\.pdf$/}
  pdfs.each do |pdf|
    path = File.join(syllabuses_path, section, pdf)
    grade = matched_section_name[1]
    department = get_enum_key(matched_section_name[2])
    attrs = parse(path, year: section_year, grade: grade, department: department)
    item = Item.new(attrs)
    unless item.save
      puts "Fail: saving #{section}/#{pdf}"
    end
  end
end
