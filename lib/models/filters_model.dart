class Filter{
  String priceLow;
  String priceHigh;

  String overallAreaLow;
  String overallAreaHigh;

  String kitchenAreaLow;
  String kitchenAreaHigh;

  String roomsQuantity = "1 комнатная";

  Filter({
    this.priceLow,
    this.priceHigh,
    this.overallAreaLow,
    this.overallAreaHigh,
    this.kitchenAreaLow,
    this.kitchenAreaHigh,
    this.roomsQuantity
});
}