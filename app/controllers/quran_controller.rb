class QuranController < ApplicationController
  def view
    root = Rails.root.to_s #make sure string
    quran = Nokogiri::XML(File.open("#{root}/lib/quran-simple.xml"))

    sura1 = quran.search('sura[index="1"]')
    @ayat = sura1.xpath('aya/@text')
  end
end
