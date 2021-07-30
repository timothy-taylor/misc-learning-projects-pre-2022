require './lib/caesarshift.rb'

describe CaesarShift do
  describe "#caesar_cipher" do
    it "returns a string of characters shifted by a key" do
      encrypted = CaesarShift.new('panda', 8)
      expect(encrypted.caesar_cipher).to eql('xivli')
    end

    it "returns a shifted version of a string with puncuation and capitals" do
      encrypted = CaesarShift.new('Panda??', 8)
      expect(encrypted.caesar_cipher).to eql('Xivli??')
    end

    it "returns a shifted version of a string with spaces" do
      encrypted = CaesarShift.new("pa nda", 8)
      expect(encrypted.caesar_cipher).to eql('xi vli')
    end

    it "returns a shifted version of a string with numbers" do
      encrypted = CaesarShift.new('panda33', 8)
      expect(encrypted.caesar_cipher).to eql('xivli33')
    end
  end

  describe "#wrapping_utility" do
    it "wraps ASCII codes" do
      encrypted = CaesarShift.new
      expect(encrypted.wrapping_utility(50, 8)).to eql(84)
    end

    it "wraps the shift-number to alphabet range of 26" do
      encrypted = CaesarShift.new
      expect(encrypted.wrapping_utility(75, (8+26))).to eql(83)
    end
  end

  describe "#char_shift" do
    it "shifts characters by the shift-number" do
      encrypted = CaesarShift.new
      expect(encrypted.char_shift('z', 3)).to eql('c')
    end

    it "shifts capitalize characters by the shift-number" do
      encrypted = CaesarShift.new
      expect(encrypted.char_shift('Z', 3)).to eql('C')
    end
  end
end
