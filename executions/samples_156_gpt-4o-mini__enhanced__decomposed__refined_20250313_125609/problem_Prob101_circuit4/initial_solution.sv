module TopModule (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    output logic q
);

    assign q = (b && (c || d)) || (a && (c || d)) || 
               (b && c) || 
               (a && ~b && c && d) || 
               (a && b && ~c) || 
               (a && b && c) || 
               (b && d);

endmodule