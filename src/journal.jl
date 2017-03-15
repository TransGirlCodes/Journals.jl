# journal.jl
# ===============
#
# A type representing a journal of an array, string, or sequence-like container,
# against a reference of some other array, string, or sequence-like container.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/Bio.jl/blob/master/LICENSE.md


@compat struct Journal{T}
    "The reference object for the journal."
    reference::T

    "A buffer containing elements required for insertions."
    buffer::T

    "A sorted vector of the journal entries."
    entries::Vector{JE}

    "The length of the journaled object."
    len::Int
end

function Journal{T}(reference::T)
        return Journal{T}(reference, T(), Vector{JE}(), 0)
end
