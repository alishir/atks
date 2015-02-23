class QuranController < ApplicationController
  def view
    root = Rails.root.to_s #make sure string
    quran = Nokogiri::XML(File.open("#{root}/lib/quran-simple.xml"))
    quran_data = Nokogiri::XML(File.open("#{root}/lib/quran-data.xml"))

    # retrieve sura number and reqAya from user request
    sura = 4
    reqAya = 32
    @page = quran_data.search("page[sura=\"#{sura}\"]").select{|page| page['aya'].to_i <= reqAya}.last['index']
    nextPage = @page.to_i + 1
    @nextPageSura = quran_data.search("page[index=\"#{nextPage}\"]").first['sura']
    @nextPageAya = quran_data.search("page[index=\"#{nextPage}\"]").first['aya']

    sura1 = quran.search('sura[index="1"]')
    @ayat = sura1.xpath('aya/@text')
  end
end
