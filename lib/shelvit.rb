# frozen_string_literal: true

require 'lcsort'

# Generates normalized shelf keys from call numbers, using the Lcsort gem.
class Shelvit
  LOWER_MAP = ('a'..'z').to_a.zip(('00'..'26').to_a).to_h

  def self.normalize(call_number)
    return if call_number.nil?

    Lcsort.normalize(call_number) || Lcsort.normalize(cleaned(call_number))
  end

  # @note If Lcsort can't properly normalize the call number, we "clean" it up by translating unsortable characters
  # into sortable ones:
  #
  # 1. Lower-case letters are translated into numbers 00 through 25. Ex. PZ7.H56774Fz becomes PZ7.H56774F25
  # 2. Colons are replaced with periods
  # 3. LC numbers that have no number after their letter classification have a '0' added. Ex, KKP.B634 becomes
  #    KKP0.B634
  def self.cleaned(call_number)
    call_number
      .gsub(/([a-z])/, LOWER_MAP)
      .gsub(/:/, '.')
      .gsub(/(^[A-Z]{1,3})\.([A-Z])/, '\10.\2')
  end

  private_class_method :cleaned
end
