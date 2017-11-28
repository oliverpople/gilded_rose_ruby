class GildedRose
  def initialize(items) # GildedRose class takes an items argument
    @items = items # GR class intializes with all items item stored in instance variable
  end

  def update_quality # Update quality class is responsible for all changes to an items quality and sell in value dependending on its attributes
    @items.each do |item| # iterates through each item
      if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert' # if item isn't Aged brie or a backstage pass it passes into the next conditional
        if item.quality > 0 # if item's QV is greater than 0 its passed into the next conditional
          if item.name != 'Sulfuras, Hand of Ragnaros' # so long as item is not sulturas...
            item.quality = item.quality - 2 # it's quality is depreciated by 1
          end
        end
      else # if the item is a Aged brie or a backstage pass...
        if item.quality < 50 # and it' QV is less than 50
          add_quality(item)
          if item.name == 'Backstage passes to a TAFKAL80ETC concert' # ...if this item is a backstage pass...
            if item.sell_in < 11 # ...with less tha 11 days left to sell...
              add_quality(item) if item.quality < 50 # ...and the items QV is still less than 50...
            end
            if item.sell_in < 6 # ...but if the item has 6 days to sell...
              add_quality(item) if item.quality < 50 # ...and it's QV is less than 50...
            end
          end
        end
      end
      if item.name != 'Sulfuras, Hand of Ragnaros' # ...if the item is not a Sulfuras
        item.sell_in = item.sell_in - 1 # ...it's sell_in deprecates by one
      end
      if item.sell_in < 0 # ...if an items sell in vlue is less than 1...
        if item.name != 'Aged Brie' # ...amd thet item isn't aged brie...
          if item.name != 'Backstage passes to a TAFKAL80ETC concert' # ...nor is it a backstage pass...
            if item.quality > 0 # ...and it's QV is greater than zero...
              if item.name != 'Sulfuras, Hand of Ragnaros' # ...and its not sulturas...
                item.quality = item.quality - 2 # ...its QV deprecates by -1
              end
            end
          else # ..else if the item's sell in value is less than 0 and it is a backstage pass
            item.quality = item.quality - item.quality # QV becomes 0
          end
        else # ...if the item is aged brie
          add_quality(item) if item.quality < 50 # ...and the QV is less than 50...
        end
      end
    end
  end
end

def add_quality(item)
  item.quality = item.quality + 1
end

class Item
  attr_accessor :name, :sell_in, :quality # all three properties of an item is accessible anywhere withiin the item class

  def initialize(name, sell_in, quality) # Item takes three arguments on initialisation and stores each as an instant variable
    @name = name # item's dirname
    @sell_in = sell_in # item's time to sell in value
    @quality = quality # item's Quality value
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}" # method interpolates and item's three attribute into a string
  end
end
