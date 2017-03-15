# journalentry.jl
# ===============
#
# A type and method used for constructing journaled sequences.
#
# This file is a part of BioJulia.
# License is MIT: https://github.com/BioJulia/Bio.jl/blob/master/LICENSE.md

const SRC = UInt8
const SRC_NULL = 0b0000
const SRC_REFERENCE = 0b0001
const SRC_INSERTION = 0b0010

"""
A JournalEntry is a struct of values which are used to represent some sub-range
of either the reference or the insertion buffer in a Journal.
"""
@compat struct JournalEntry
    "A flag for where the segment maps (reference or insertion buffer)."
    source::SRC

    "Position in the reference string, or insertion buffer."
    physicalpos::Int

    "The physical position in the virtual string."
    virtualpos::Int

    "The physical position in the reference string."
    physicaloriginpos::Int

    "The length of the segment."
    len::Int
end

const JE = JournalEntry

JournalEntry() = JournalEntry(SRC_NULL, 0, 0, 0, 0)

source(entry::JE) = entry.source

"Test if the segment represents a region of the reference."
isorigional(entry::JE) = source(entry) == SRC_REFERENCE

"Test if the segment represents a region of the insertion buffer."
isinsertion(entry::JE) = source(entry) == SRC_INSERTION

"Get the physical location in the target."
vposition(entry::JE) = entry.virtualpos

"Get the position in the origonal string, or insertion buffer."
pposition(entry::JE) = entry.physicalpos

"Get the physical origin position in the reference string."
poposition(entry::JE) = entry.phyoriginpos

ltvirtual(entrya::JE, entryb::JE) = isless(vposition(entrya), vposition(entryb))

Base.isless(entrya::JE, entryb::JE) = ltvirtual(entrya, entryb)

Base.length(entry::JE) = entry.len

Base.isnull(entry::JE) = source(entry) == SRC_NULL 

function Base.show(io::IO, ::MIME"text/plain", entry::JE)
    println(io, "Source of Segment: $(source(entry))")
    println(io, "Virtual Position: $(vposition(entry))")
    println(io, "Physical Position: $(pposition(entry))")
    println(io, "Physical Origin Position: $(poposition(entry))")
    println(io, "Length of Segment: $(length(entry))")
end
