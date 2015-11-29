$ ->
  $(document).on 'change', '#aaaacustomer_company_code', (evt) ->
    $.ajax 'customers/update_stores',
      type: 'GET'
      dataType: 'script'
      data: {
        company_code: $("#customer_company_code option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")