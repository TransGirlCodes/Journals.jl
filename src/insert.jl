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
