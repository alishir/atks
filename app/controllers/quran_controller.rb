class QuranController < ApplicationController
  def view
    root = Rails.root.to_s #make sure string
    quran = Nokogiri::XML(File.open("#{root}/lib/quran-simple.xml"))
    quran_data = Nokogiri::XML(File.open("#{root}/lib/quran-data.xml"))

    # retrieve sura number and reqAya from user request
    reqSura = 4
    reqAya = 32
    @page = quran_data.search("page[sura=\"#{reqSura}\"]").select{|page| page['aya'].to_i <= reqAya}.last['index']
    nextPage = @page.to_i + 1
    @nextPageSura = quran_data.search("page[index=\"#{nextPage}\"]").first['sura']
    @nextPageAya = quran_data.search("page[index=\"#{nextPage}\"]").first['aya']

    sura1 = quran.search("sura[index=\"#{reqSura}\"]")
    @sura = reqSura
    @ayat = sura1.xpath('aya').select{|aya| aya['index'].to_i < @nextPageAya.to_i && aya['index'].to_i >= reqAya}
  end
end
