"""
Split ways at intersections.

Note that the tags dictionary is _not_ copied; any modifications to tags of one part of
a split way will affect other parts.
"""
function split_way(way, intersections)
    if length(way.nodes) ≤ 2
        return [way]
    end

    result = Vector{Way}()
    split_nodes = [way.nodes[1]]

    for (pos, node) in enumerate(way.nodes[2:end])
        push!(split_nodes, node)

        # if it's an intersection or the last node, save the way
        if node ∈ intersections || pos + 1 == length(way.nodes)
            # this node is an intersection, break the way here
            push!(result, Way(way.id, split_nodes, way.tags))
            split_nodes = [node]
            # next split starts with same node
            push!(split_nodes, node)
        end
    end

    return result
end