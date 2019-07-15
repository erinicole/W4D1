class PolyTreeNode
    attr_reader :parent, :children, :value
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end
    
    def parent=(new_parent)
        old_parent = @parent
        old_parent.children.delete(self) unless old_parent.nil?
        @parent = new_parent        
        parent.children << self unless parent.nil?
    end

    def add_child(node)
        node.parent = self
    end

    def remove_child(node)
        if children.include?(node)
            node.parent = nil
        else
            raise "this is not a child"
        end
    end

    def dfs(target)
        return self if value == target
        
        children.each do |child|
            result = child.dfs(target)
            return result unless result == nil
        end
        
        nil
    end

    def bfs(target)
        queue = []
        queue << self

        until queue.empty?
            current_node = queue.shift
            return current_node if current_node.value == target
            queue.concat(current_node.children)
        end

        nil
    end
end
