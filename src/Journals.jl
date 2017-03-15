module Journals

using Compat

include("journalentry.jl")
include("journal.jl")

export
    Journal

end
