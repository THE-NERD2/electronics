electronics = {}

function electronics.register_wire(name, def)
    --[[
        def = {
            description = ...,
            texture = ...,
            ports = (see ports usage),
            power_update = (see power_update usage)
        }
    ]]
    local c = 1 / 16
    local connect_sides = {}
    local node_box = {
        type = "connected",
        fixed = {{-c, -0.5, -c, c, -0.5 + c, c}}
    }
    local selection_box = {
        type = "connected",
        fixed = {{-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}}
    }
    for _, port in ipairs(def.ports) do
        if port == "-x" then
            table.insert(connect_sides, "left")
            node_box.connect_left = {{-0.5, -0.5, -c, -c, -0.5 + c, c}}
        elseif port == "+x" then
            table.insert(connect_sides, "right")
            node_box.connect_right = {{c, -0.5, -c, 0.5, -0.5 + c, c}}
        elseif port == "-z" then
            table.insert(connect_sides, "back")
            node_box.connect_back = {{-c, -0.5, 0.5, c, -0.5 + c, c}}
        elseif port == "+z" then
            table.insert(connect_sides, "front")
            node_box.connect_front = {{-c, -0.5, -c, c, -0.5 + c, -0.5}}
        elseif port == "+y" then
            table.insert(connect_sides, "top")
            node_box.connect_top = {{-c, -0.5 + c, -c, c, 0.5, c}}
            selection_box.connect_top = {{-2 * c, -0.4, -2 * c, 2 * c, 0.5, 2 * c}}
        end
    end
    minetest.register_node(name, {
        description = def.description,
        groups = {cracky = 3},
        paramtype = "light",
        paramtype2 = "facedir",
        drawtype = "nodebox",
        tiles = {def.texture},
        connect_sides = connect_sides,
        connects_to = {name},
        node_box = node_box,
        collision_box = {
            type = "fixed",
            fixed = {{0, 0, 0, 0, 0, 0}}
        },
        selection_box = selection_box
    })
end