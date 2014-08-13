$.fn.optionValueAutocomplete = ->
  'use strict'
  @select2
    minimumInputLength: 1
    multiple: true
    initSelection: (element, callback) ->
      $.get Spree.routes.option_values_search,
        ids: element.val().split(',')
      , (option_values) ->
        callback option_values
        return

      return

    ajax:
      url: Spree.routes.option_values_search
      datatype: 'json'
      data: (term, page) ->
        q:
          name_cont: term
          sku_cont: term

        m: 'OR'
        token: Spree.api_key

      results: (data, page) ->
        option_values = (if data then data else [])
        results: option_values

    formatResult: (option_value) ->
      option_value.name

    formatSelection: (option_value) ->
      option_value.name

  return
