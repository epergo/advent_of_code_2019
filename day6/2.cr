class SpaceObject
  # Name of this SpaceObject
  getter label : String

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

  # Labels of all ancestors
  def ancestors : Array(String)
    result = [] of String
    return result if is_root?

    result.push(@parent.not_nil!.label)
    result.concat(@parent.not_nil!.ancestors)

    result
  end

  def transfer_to(destination : String) : Int32
    ancestors.index(destination) || -1
  end
end

# `configurations` will follow this structure:
# ["COM)B", "B)C", "C)D", ...]
# `read_configuration` parse and returns a Hash with every space object and its parent
def read_configuration(configurations : Array(String)) : Hash(String, SpaceObject)
  configurations.reduce({} of String => SpaceObject) do |acc, configuration|
    # example configuration: C)D
    parent_label, child_label = configuration.split(")")

    parent = acc.fetch(parent_label) do |label|
      # Parent does not exist, create and save it
      acc[label] = SpaceObject.new(label)
    end

    child = acc.fetch(child_label) do |label|
      # Child does not exist, create, associate with parent and save it
      acc[label] = SpaceObject.new(label, parent)
    end

    child.parent = parent if child.parent.nil?

    acc
  end
end

def orbital_transfers_between(label1 : String, label2 : String, configurations : Array(String)) : Int32
  space_objects = read_configuration(configurations)
  object1 = space_objects[label1]
  object2 = space_objects[label2]

  shared_ancestor = (object1.ancestors & object2.ancestors).first

  object1.transfer_to(shared_ancestor) + object2.transfer_to(shared_ancestor)
end
