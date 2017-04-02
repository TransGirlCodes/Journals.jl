# journal.jl
# ===============
#
# A type representing a journal of an array, string, or sequence-like container,
# against a reference of some other array, string, or sequence-like container.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/Bio.jl/blob/master/LICENSE.md


type Journal{T}
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
    l = length(reference)
    return Journal{T}(reference, T(), init_entries(l), l)
end

@inline function init_entries(l::Int)
    v = Vector{JE}(1)
    v[1] = JournalEntry(SRC_REFERENCE, 1, 1, 1, l)
    return v
end

function Base.show{T}(io::IO, ::MIME"text/plain", j::Journal{T})
    println(io, "A ", T, " of length ", length(j), " in a journalled format.")
    println(io, "Reference:")
    println(io, reference(j))
end

Base.length(j::Journal) = j.len

@inline function reinit_entries!(j::Journal, l::Int)
    j.entries = init_entries(l)
end

reference(j::Journal) = j.reference
function reference!{T}(j::Journal{T}, ref::T)
    j.reference = ref
    l = length(ref)
    j.len = l
    reinit_entries!(j, l)
end

function clear{T}(j::Journal{T})
    l = length(reference(j))
    reinit_entries!(j, l)
    j.buffer = T()
    j.len = l
end








function insert_record!(tree::Vector{JE}, vpos, bufferpos, len)
    # We find the last entry in the journal with a virtual
    # position that is lower or equal to vpos.
    refEntry = JournalEntry(SRC_NULL, 0, vpos, 0, 0)
    insertpoint = searchsortedlast(tree, refEntry)
    ie = tree[insertpoint]
    ievpos = vposition(ie)

    # Now we need to create new journal entries.

    # If the journal entry found above, contains the virtual position we
    # want to insert into.
    if (ievpos + length(ie)) > vpos
        if ievpos == vpos

        end


    end


end


"""
    insert!(j, ins)

Insert a piece of data into the reference.

This adds an insertion entry into the journal, and updates other entries.
"""
function insert!{T}(j::Journal{T}, ins::T, idx::Int)
    # The length of the journalled data increases.
    l = length(ins)
    j.len += l
    # Note the length of the buffer before insertion.
    bufferstart = length(j.buffer)
    # Add the insertion onto the buffer.
    append!(j.buffer, ins)
    # Insert a record into the tree.
    insert_record!(j.entries, idx, bufferstart, l)
end
