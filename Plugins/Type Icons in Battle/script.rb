class Battle::Scene::PokemonDataBox

  alias __types__initializeOtherGraphics initializeOtherGraphics unless method_defined?(:__types__initializeOtherGraphics)  
  def initializeOtherGraphics(*args)
    @types_x = (@battler.opposes?(0)) ? 24 : -40
    @types_bitmap = AnimatedBitmap.new("Graphics/UI/Battle/icon_types")
    @types_sprite = Sprite.new(viewport)
    height = @types_bitmap.height / GameData::Type.count
    @types_y = -height
    @types_sprite.bitmap = Bitmap.new(@databoxBitmap.width - @types_x, height)
    @sprites["types_sprite"] = @types_sprite
    __types__initializeOtherGraphics(*args)
  end

  alias __types__dispose dispose unless method_defined?(:__types__dispose)  
  def dispose(*args)
    __types__dispose(*args)
    @types_bitmap.dispose
  end

  alias __types__set_x x= unless method_defined?(:__types__set_x)
  def x=(value)
    __types__set_x(value)
    @types_sprite.x = value + @types_x
  end

  alias __types__set_y y= unless method_defined?(:__types__set_y)
  def y=(value)
    __types__set_y(value)
    @types_sprite.y = value + @types_y + 50
  end

  alias __types__set_z z= unless method_defined?(:__types__set_z)
  def z=(value)
    __types__set_z(value)
    @types_sprite.z = value + 1
  end

  alias __databox__refresh refresh unless method_defined?(:__databox__refresh)
  def refresh
    self.bitmap.clear
    return if !@battler.pokemon
    __databox__refresh
    draw_type_icons
  end

  def draw_type_icons
    # Draw Pokémon's types
    @types_sprite.bitmap.clear
    width  = @types_bitmap.width
    height = @types_bitmap.height / GameData::Type.count
    @battler.types.each_with_index do |type, i|
      type_number = GameData::Type.get(type).icon_position
      type_rect = Rect.new(0, type_number * height, width, height) 
      @types_sprite.bitmap.blt((width - 6) * i, 0, @types_bitmap.bitmap, type_rect)
    end
  end
end
