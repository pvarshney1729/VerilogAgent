module TopModule (
    input logic a,        // Single bit input signal
    input logic b,        // Single bit input signal
    input logic sel_b1,   // Single bit select signal
    input logic sel_b2,   // Single bit select signal
    output logic out_assign, // Single bit output from assign statement
    output logic out_always   // Single bit output from procedural block
);

    // Assign statement logic
    assign out_assign = (sel_b1 && sel_b2) ? b : a;

    // Procedural block logic
    always @(*) begin
        if (sel_b1 && sel_b2) begin
            out_always = b;
        end else begin
            out_always = a;
        end
    end

endmodule