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
    for _, port in ipairs(def.ports) do
        if port == "xm" then
            table.insert(connect_sides, "left")
            node_box.connect_left = {{-0.5, -0.5, -c, -c, -0.5 + c, c}}
        elseif port == "xp" then
            table.insert(connect_sides, "right")
            node_box.connect_right = {{c, -0.5, -c, 0.5, -0.5 + c, c}}
        elseif port == "zm" then
            table.insert(connect_sides, "back")
            node_box.connect_back = {{-c, -0.5, 0.5, c, -0.5 + c, c}}
        elseif port == "zp" then
            table.insert(connect_sides, "front")
            node_box.connect_front = {{-c, -0.5, -c, c, -0.5 + c, -0.5}}
        end
    end
    minetest.register_node(name, {
        description = def.description,
        groups = {cracky = 3},
        paramtype = "light",
        drawtype = "nodebox",
        tiles = {def.texture},
        connect_sides = connect_sides,
        connects_to = {name},
        node_box = node_box,
        collision_box = {
            type = "fixed",
            fixed = {{0, 0, 0, 0, 0, 0}}
        },
        selection_box = {
            type = "fixed",
            fixed = {{-0.5, -0.5, -0.5, 0.5, -0.1, 0.5}}
        }
    })
end