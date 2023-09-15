class User::DisplayNameBuilder
  attr_accessor :base_display_name

  def initialize(user)
    @user = user
    @counter = 0
    @base_display_name = generate_base_display_name(user)
  end

  def escape(str)
    s = I18n.transliterate str.to_s
    s.gsub!(/[^a-z]+/i, '') # remove all non-word characters after transliteration
    s.strip!
    s.downcase!
    s
  end

  def display_name_available?(display_name)
    !User.exists?(display_name: display_name)
  end

  def next_display_name
    @counter >= 999 and raise 'cannot generate a display_name for this user'
    "#{base_display_name.first(17)}#{@counter += 1}"
  end

  def first_last_name_character(user)
    escape(user.last_name).first(1)
  end

  def generate_base_display_name(user)
    base = escape(user.first_name.to_s[/\A\s*(\S+)/, 1]) # Ignore leading spaces and fetch the first non-ws token
    first_last_name_character(user).full? { |char| base << "_#{char}" }
    base.full?(:first, 20) || generate_token(10)
  end

  def assign_display_name!
    @user.display_name.present? and return
    new_display_name = base_display_name
    (new_display_name = next_display_name) until display_name_available?(new_display_name)
    @user.display_name = new_display_name
  end

  # Generate a token string of length "size". The string
  # will be url safe. Pass +block+ to regenerature until its return value
  # becomes truthy.
  def generate_token(size = 64, &block)
    block ||= ->* { true }
    loop do
      token = Tins::Token.new(
        length: size,
        alphabet: Tins::Token::BASE64_URL_FILENAME_SAFE_ALPHABET,
      )
      return token if block.call(token)
    end
  end
end
