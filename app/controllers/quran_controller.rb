class QuranController < ApplicationController
  def view
    root = Rails.root.to_s #make sure string
    quran = Nokogiri::XML(File.open("#{root}/lib/quran-simple.xml"))
    quran_data = Nokogiri::XML(File.open("#{root}/lib/quran-data.xml"))

    # retrieve sura number and reqAya from user request
    reqSura = 4
    reqAya = 28
    pageNode = quran_data.search("page[sura=\"#{reqSura}\"]").select{|page| page['aya'].to_i <= reqAya}.last
    firstAyaOfPage = pageNode['aya'].to_i
    @page = pageNode['index']
    nextPage = @page.to_i + 1
    @nextPageSura = quran_data.search("page[index=\"#{nextPage}\"]").first['sura']
    @nextPageAya = quran_data.search("page[index=\"#{nextPage}\"]").first['aya']

    sura1 = quran.search("sura[index=\"#{reqSura}\"]")
    @suraName = sura1.first['name']
    @sura = reqSura
    @ayat = sura1.xpath('aya').select{|aya| aya['index'].to_i < @nextPageAya.to_i && aya['index'].to_i >= firstAyaOfPage}
  end

  def view_page
    reqPage = params[:page]

    root = Rails.root.to_s #make sure string
    quran = Nokogiri::XML(File.open("#{root}/lib/quran-simple.xml"))
    quran_data = Nokogiri::XML(File.open("#{root}/lib/quran-data.xml"))

    pageNode = quran_data.search("page[index=\"#{reqPage}\"]").first
    suraNum = pageNode['sura']
    firstAyaOfPage = pageNode['aya'].to_i
    nextPage = reqPage.to_i + 1
    nextPageAya = quran_data.search("page[index=\"#{nextPage}\"]").first['aya']

    suraNode = quran.search("sura[index=\"#{suraNum}\"]")
    @suraName = suraNode.first['name']
    @sura = suraNum
    @ayat = suraNode.xpath('aya').select{|aya| aya['index'].to_i < nextPageAya.to_i &&
        aya['index'].to_i >= firstAyaOfPage}
    @page = reqPage

    respond_to do |format|
      format.js
    end
  end

end
