class SarfAnalysisController < ApplicationController
  def analyze_token
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
