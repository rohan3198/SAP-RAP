@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TRAVEL CDS'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZRK_TRAVEL_CDS
  as select from zrk_travel_m as travel

  composition [0..*] of zrk_booking_cds          as _Booking

  association [0..1] to /DMO/I_Agency            as _Agency        on $projection.agency_id = _Agency.AgencyID
  association [0..1] to /DMO/I_Customer          as _Customer      on $projection.customer_id = _Customer.CustomerID
  association [0..1] to I_Currency               as _Currency      on $projection.currency_code = _Currency.Currency
  association [1..1] to /DMO/I_Overall_Status_VH as _OverallStatus on $projection.overall_status = _OverallStatus.OverallStatus
{
  key travel_id,
      agency_id,
      customer_id,
      begin_date,
      end_date,
      @Semantics.amount.currencyCode: 'currency_code'
      booking_fee,
      @Semantics.amount.currencyCode: 'currency_code'
      total_price,
      currency_code,
      overall_status,
      description,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.localInstanceLastChangedBy: true
      last_changed_by,
      //local ETag field --> OData ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at,

      /* Associations */
      _Booking,
      _Agency,
      _Customer,
      _Currency,
      _OverallStatus
}
