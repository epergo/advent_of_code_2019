class SpaceObject
  # Name of this SpaceObject
  @label : String

  # Around which SpaceObject is this one orbiting
  property parent : SpaceObject | Nil

  def initialize(@label, @parent = nil); end

  # Return the sum of all direct and indirect orbits for this SpaceObject
  def orbits : Int32
    return 0 if is_root?

    1 + @parent.not_nil!.orbits
  end

  # Root SpaceObject does not have a parent
  def is_root? : Bool
    @parent.nil?
  end
end

# `configurations` will follow this structure:
# ["COM)B", "B)C", "C)D", ...]
def total_orbits(configurations : Array(String)) : Int32
  space_objects = {} of String => SpaceObject
  configurations.each do |configuration|
    # example configuration: C)D
    parent_label, child_label = configuration.split(")")

    parent = space_objects.fetch(parent_label) do |label|
      # Parent does not exist, create and save it
      space_objects[label] = SpaceObject.new(label)
    end

    child = space_objects.fetch(child_label) do |label|
      # Child does not exist, create, associate with parent and save it
      space_objects[label] = SpaceObject.new(label, parent)
    end

    child.parent = parent if child.parent.nil?
  end

  space_objects.values.sum { |so| so.orbits }
end
