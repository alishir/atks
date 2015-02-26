class QuranController < ApplicationController
  def view
    root = Rails.root.to_s #make sure string
    quran = Nokogiri::XML(File.open("#{root}/lib/quran-simple.xml"))
    quran_data = Nokogiri::XML(File.open("#{root}/lib/quran-data.xml"))

    # retrieve sura number and reqAya from user request
    reqSura = 4
    reqAya = 28
    @page = quran_data.search("page[sura=\"#{reqSura}\"]").select{|page| page['aya'].to_i <= reqAya}.last['index']
    nextPage = @page.to_i + 1
    @nextPageSura = quran_data.search("page[index=\"#{nextPage}\"]").first['sura']
    @nextPageAya = quran_data.search("page[index=\"#{nextPage}\"]").first['aya']

    sura1 = quran.search("sura[index=\"#{reqSura}\"]")
    @sura = reqSura
    @ayat = sura1.xpath('aya').select{|aya| aya['index'].to_i < @nextPageAya.to_i && aya['index'].to_i >= reqAya}
  end

  def fetch_info
    require 'savon'
    word = params[:word]

    client = Savon.client(wsdl: "https://atks.microsoft.com/Services/SarfService.svc",
                          endpoint: "https://atks.microsoft.com/Services/SarfService.svc",
                          namespace: "http://nlptoolkit.cloudapp.net", pretty_print_xml: true,
                          log: true, log_level: :debug, env_namespace: :soapenv, namespace_identifier: :nlp)

    atks_result = client.call(:analyze_token, message: {"nlp:appId" => ATKS_API_KEY, "nlp:word" => word })
    @result = atks_result.to_hash[:analyze_token_response][:analyses]
    logger.info "result:" + @result.to_s

    # @result = "some random result" + params[:word]
    respond_to do |format|
      format.js
    end
  end
end
