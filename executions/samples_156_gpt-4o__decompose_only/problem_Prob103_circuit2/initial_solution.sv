module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic q
);

    // Implementing the logic function derived from the truth table
    assign q = (~a & ~b & ~c & ~d) | 
               (~a & ~b &  c &  d) | 
               (~a &  b & ~c &  d) | 
               (~a &  b &  c & ~d) | 
               ( a & ~b & ~c &  d) | 
               ( a & ~b &  c & ~d) | 
               ( a &  b & ~c & ~d) | 
               ( a &  b &  c &  d);

endmodule