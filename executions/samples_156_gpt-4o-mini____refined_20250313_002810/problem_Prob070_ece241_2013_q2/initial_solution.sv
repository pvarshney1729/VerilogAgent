module TopModule (
    input  logic a,
    input  logic b,
    input  logic c,
    input  logic d,
    output logic out_sop,
    output logic out_pos
);

    // out_sop: Logic-1 for 2 (0010), 7 (0111), 15 (1111)
    // out_pos: Logic-0 for 0 (0000), 1 (0001), 4 (0100), 5 (0101), 6 (0110), 9 (1001), 10 (1010), 13 (1101), 14 (1110)
    
    assign out_sop = (a == 1'b0 && b == 1'b1 && c == 1'b1 && d == 1'b1) || // 7
                     (a == 1'b0 && b == 1'b0 && c == 1'b1 && d == 1'b0) || // 2
                     (a == 1'b1 && b == 1'b1 && c == 1'b1 && d == 1'b1);   // 15

    assign out_pos = (a && b && c && d) || // 15
                     (a && b && c && !d) || // 14
                     (a && !b && c && d) || // 13
                     (a && !b && c && !d) || // 12
                     (!a && b && !c && d) || // 10
                     (!a && b && c && !d) || // 6
                     (!a && !b && c && d) || // 5
                     (!a && !b && !c && d) || // 4
                     (!a && !b && c && !d) || // 2
                     (!a && b && !c && !d);   // 1

endmodule