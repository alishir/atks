class SarfAnalysisController < ApplicationController
  def analyze_token
    if Rails.env.production?
      require 'savon'

      word = params[:word]

      client = Savon.client(wsdl: "https://atks.microsoft.com/Services/SarfService.svc",
                            endpoint: "https://atks.microsoft.com/Services/SarfService.svc",
                            namespace: "http://nlptoolkit.cloudapp.net", pretty_print_xml: true,
                            log: true, log_level: :debug, env_namespace: :soapenv, namespace_identifier: :nlp)

      atks_result = client.call(:analyze_token, message: {"nlp:appId" => ATKS_API_KEY, "nlp:word" => word })
      @result = atks_result.to_hash[:analyze_token_response][:analyses][:sarf_analysis]
    end

    if Rails.env.development?
      @result = [{:diac_token=>"مُدْخَلًا", :stem=>"مُدْخَل", :root=>"دخل", :pattern=>"مُفْعَل",
                  :pos=>"ESM_MAF3OOL_MAZEED", :prefix1=>"PREFIX_NULL", :prefix2=>"PREFIX_NULL",
                  :prefix3=>"PREFIX_NULL", :suffix1=>"SUFFIX_ALEF_TANWEEN", :suffix2=>"SUFFIX_NULL",
                  :suffix3=>"SUFFIX_NULL", :is_definitive_al=>false, :is_nunation=>false,
                  :is_borrowed_word=>false, :is_proper_name=>false, :is_title=>false, :nunatable=>true,
                  :accusative_nunatable=>true, :geneative_nunatable=>false, :nominative_nunatable=>false,
                  :prop100=>true, :prop90=>false, :prop80=>false, :prop70=>false, :prop60=>false,
                  :prop50=>false, :prop40=>false, :prop30=>false, :prop20=>false, :prop10=>false,
                  :prop0=>false, :case_ending_included=>true, :verb_pos=>false,
                  :morpho_syntactic_features=>"39599598518533", :probability=>"0.9999818"},
                 {:diac_token=>"مُدْخَلًا", :stem=>"مُدْخَل", :root=>"دخل", :pattern=>"مُفْعَل",
                  :pos=>"MASDAR_MEEMEY_MAZEED", :prefix1=>"PREFIX_NULL", :prefix2=>"PREFIX_NULL",
                  :prefix3=>"PREFIX_NULL", :suffix1=>"SUFFIX_ALEF_TANWEEN", :suffix2=>"SUFFIX_NULL",
                  :suffix3=>"SUFFIX_NULL", :is_definitive_al=>false, :is_nunation=>false,
                  :is_borrowed_word=>false, :is_proper_name=>false, :is_title=>false, :nunatable=>true,
                  :accusative_nunatable=>true, :geneative_nunatable=>false, :nominative_nunatable=>false,
                  :prop100=>false, :prop90=>false, :prop80=>false, :prop70=>false, :prop60=>false,
                  :prop50=>false, :prop40=>false, :prop30=>false, :prop20=>false, :prop10=>false,
                  :prop0=>true, :case_ending_included=>true, :verb_pos=>false,
                  :morpho_syntactic_features=>"109968342647045", :probability=>"1.82007861E-05"}]
    end

    logger.info "result:" + @result.to_s

    respond_to do |format|
      format.js
    end
  end
end
