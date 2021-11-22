module Validator
  class << self
    attr_accessor :wagoon_type, :train_num
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private # метод для валидации введенного значения
  def validate!
    raise "Номер не может быть пустым" if @train_num==""
    raise "Номер не может быть меньше 3х символов" if @train_num.length<3
    if [1,2].include?(@wagoon_type)
      return
    else
      raise "Вы ввели не существующий тип вагона"
    end
  end
end
