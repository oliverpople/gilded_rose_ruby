require  './gilded_rose.rb'

describe GildedRose do
  describe '#update_quality' do

    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'doubles the rate of quality degradation once a standard item passes its sell by date' do
      items = [Item.new('foo', 0, 2)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(0)
    end

    it 'doesn\'t allow standard items to have negative quality values' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(0)
    end

    it 'increases the quality of aged brie the older it gets' do
      items = [Item.new('Aged Brie', 1, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(1)
    end

    it 'the quality of any item is never more than 50' do
      items = [Item.new('Aged Brie', 1, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(50)
    end

    it 'never decreases the Quality Sulfuras, Hand of Ragnaros' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(50)
    end

    it 'increases the quality value of backstages passes by x2 when there are 10days of less to sellin' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(2)
    end

    it 'increases the quality value of backstages passes by x3 when there are 5days of less to sellin' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(3)
    end

    it 'decreases the quality value of backstages passes to 0 when sellin value is less than zero' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(0)
    end

    it 'increases the quality value of Aged Brie by +2, if it has a quality value less than 50 and a sellin less than 0' do
      items = [Item.new('Aged Brie', 0, 48)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(50)
    end

    it 'degrades the quality value of standard items by 2' do
      items = [Item.new('foo', 1, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq(8)
    end

  end
end

# # Requirements to test
#
# - Once the sell by date has passed, Quality degrades twice as fast  /
# - The Quality of an item is never negative  /
# - “Aged Brie” actually increases in Quality the older it gets /
# - The Quality of an item is never more than 50 /
# - “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality /
# - “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches;
#   Quality increases by 2 when there are 10 days or less and by 3 when there
#   are 5 days or less but Quality drops to 0 after the concert /
#
# - “Conjured” items degrade in Quality twice as fast as normal items
#
