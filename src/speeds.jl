const MILES_TO_KILOMETERS = 1.609344
const KNOTS_TO_KMH = 1.852

function read_speeds(filename)
    speedtable = CSV.read(filename, DataFrame)

    speeds = Dict{String, Float64}()

    for row in eachrow(speedtable)
        speed = parse_max_speed(row.speed)
        ismissing(speed) && error("Failed to parse speed $(row.speed)")
        highway = lowercase(row.highway)
        speeds[highway] = speed
    end

    return speeds
end

const CAR_SPEED_TAGS = ["maxspeed:motorcar", "maxspeed:motor_vehicle", "maxspeed:vehicle", "maxspeed"]

function maxspeed_for_way(w, speeds)
    for tag in CAR_SPEED_TAGS
        if haskey(w.tags, tag)
            speed = parse_max_speed(w.tags[tag])
            if !ismissing(speed)
                return speed
            end
        end
    end

    # fall back to highway-based speeds
    highway = lowercase(w.tags["highway"])
    if haskey(speeds, highway)
        return speeds[highway]
    else
        return speeds["default"]
    end
end

function parse_max_speed(speed_text)::Union{Float64, Missing}
    try
        return parse(Float64, speed_text)
    catch
        # not a raw km/hr number
        mtch = match(r"([0-9]+)(?: ?)([a-zA-Z/]+)", speed_text)
        if isnothing(mtch)
            @warn "unable to parse speed limit $speed_text"
            return missing
        else
            speed_scalar = parse(Float64, mtch.captures[1])
            units = lowercase(mtch.captures[2])

            if (units == "kph" || units == "km/h" || units == "kmph")
                return speed_scalar
            elseif units == "mph" || units == "moh" # common error
                return speed_scalar * MILES_TO_KILOMETERS
            elseif units == "knots"
                return speed_scalar * KNOTS_TO_KMH
            else
                @warn "unknown speed unit $units"
                return missing
            end
        end
    end
end

function oneway_for_way(w)
    oneway = 0
    if haskey(w.tags, "oneway")
        owt = w.tags["oneway"]
        if (owt == "yes" || owt == "1" || owt == "true")
            oneway = 1
        elseif (owt == "-1" || owt == "reverse")
            oneway = -1
        end
    end

    # implied one way, but only if it hasn't already been set e.g. to -1
    if (oneway == 0 &&
            w.tags["highway"] ∈ Set(["motorway", "motorway_link"]) ||
            haskey(w.tags, "junction") && w.tags["junction"] ∈ Set(["roundabout", "rotary", "traffic_circle"])
    ) && !(haskey(w.tags, "oneway") && w.tags["oneway"] == "no")
        oneway = 1
    end

    oneway
end