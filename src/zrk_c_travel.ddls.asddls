@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for travel cds'
@Metadata.ignorePropagatedAnnotations: true
@UI: {
  headerInfo: { typeName: 'Travel', typeNamePlural: 'Travels', title: { type: #STANDARD, value: 'travel_id' } } }

@Search.searchable: true
define root view entity zrk_c_travel
  provider contract transactional_query
  as projection on ZRK_TRAVEL_CDS
{
      @UI.facet: [ { id:              'Travel',
                          purpose:         #STANDARD,
                          type:            #IDENTIFICATION_REFERENCE,
                          label:           'Travel',
                          position:        10 } ,
                        { id:              'Booking',
                          purpose:         #STANDARD,
                          type:            #LINEITEM_REFERENCE,
                          label:           'Booking',
                          position:        20,
                          targetElement:   '_Booking'}]

      @UI: {
          lineItem:       [ { position: 10, importance: #HIGH } ],
          identification: [ { position: 10 } ] }
      @Search.defaultSearchElement: true
  key travel_id,
      @UI: {
             lineItem:       [ { position: 20, importance: #HIGH } ],
             identification: [ { position: 20 } ],
             selectionField: [ { position: 20 } ] }
      @Consumption.valueHelpDefinition: [{ entity : {name: '/DMO/I_Agency_StdVH', element: 'AgencyID'  }, useForValidation: true }]
      @ObjectModel.text.element: ['AgencyName']
      @Search.defaultSearchElement: true
      agency_id,
      _Agency.Name as AgencyName,
      @UI: {
          lineItem:       [ { position: 30, importance: #HIGH } ],
          identification: [ { position: 30 } ],
          selectionField: [ { position: 30 } ] }
      @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Customer_StdVH', element: 'CustomerID' }, useForValidation: true}]
      @ObjectModel.text.element: ['CustomerName']
      @Search.defaultSearchElement: true
      customer_id,
       _Customer.LastName as CustomerName,
            @UI: {
          identification:[ { position: 40 } ] }
      begin_date,
         @UI: {
          identification:[ { position: 41 } ] }
      end_date,
      @UI: {
          lineItem:       [ { position: 42, importance: #MEDIUM } ],
          identification: [ { position: 42 } ] }
      @Semantics.amount.currencyCode: 'Currency_Code'
      booking_fee,
        @UI: {
          lineItem:       [ { position: 43, importance: #MEDIUM } ],
          identification: [ { position: 43, label: 'Total Price' } ] }
      @Semantics.amount.currencyCode: 'Currency_Code'
      total_price,
        @Consumption.valueHelpDefinition: [{entity: {name: 'I_CurrencyStdVH', element: 'Currency' }, useForValidation: true }]
      currency_code,
      @UI: {
          lineItem:       [ { position: 15, importance: #HIGH },
                            { type: #FOR_ACTION, dataAction: 'acceptTravel', label: 'Accept Travel' },
                            { type: #FOR_ACTION, dataAction: 'rejectTravel', label: 'Reject Travel' } ],
          identification: [ { position: 15 }, 
                            { type: #FOR_ACTION, dataAction: 'acceptTravel', label: 'Accept Travel' },
                            { type: #FOR_ACTION, dataAction: 'rejectTravel', label: 'Reject Travel' } ] ,
          textArrangement: #TEXT_ONLY,
          selectionField: [ { position: 40 } ] }
      @EndUserText.label: 'Overall Status'
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Overall_Status_VH', element: 'OverallStatus' }}]
      @ObjectModel.text.element: ['OverallStatusText'] 
      overall_status,
         @UI.hidden: true
      _OverallStatus._Text.Text as OverallStatusText : localized,
        @UI: {
          lineItem: [ { position: 45, importance: #MEDIUM } ],
          identification:[ { position: 45 } ] }
      description,
      
        @UI.hidden: true
      last_changed_at,
      
      
      /* Associations */
       _Booking : redirected to composition child zrk_c_booking,
      _Agency,
      _Customer,
      _OverallStatus
}
