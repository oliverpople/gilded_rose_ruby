class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'Aged Brie' then  aged_brie_update(item)
      when 'Backstage passes to a TAFKAL80ETC concert' then backstage_pass_update(item)
      when 'Sulfuras, Hand of Ragnaros' then sulfuras_update(item)
      else standard_update(item)
      end
    end
  end

  def standard_update(item)
    subtract_sell_in(item)
    if item.sell_in < 0 && item.quality >= 4
      subtract_quality(item, 4)
    elsif item.sell_in < 0 && item.quality >= 2
      subtract_quality(item)
    elsif item.quality >= 2
      subtract_quality(item)
    end
  end

  def aged_brie_update(item)
    subtract_sell_in(item)
    if item.quality < 50
      add_quality(item)
      add_quality(item) if item.sell_in < 0
      end
  end

  def backstage_pass_update(item)
    subtract_sell_in(item)
    if item.sell_in < 0
      zero_quality(item)
    elsif item.sell_in < 6
      add_quality(item, 3)
    elsif item.sell_in < 11
      add_quality(item, 2)
    elsif item.sell_in < 50
      add_quality(item)
    end
  end

  def sulfuras_update(item); end

private

  def add_quality(item, n=1)
    item.quality = item.quality + n
  end

  def subtract_quality(item, n=2)
    item.quality = item.quality - n
  end

  def subtract_sell_in(item)
    item.sell_in = item.sell_in - 1
  end

  def zero_quality(item)
    item.quality = item.quality - item.quality
  end
  end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
