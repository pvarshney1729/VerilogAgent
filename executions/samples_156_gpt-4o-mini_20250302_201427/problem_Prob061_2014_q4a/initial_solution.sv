module TopModule (
    input logic clk,
    input logic w,
    input logic R,
    input logic E,
    input logic L,
    input logic nReset,
    output logic Q
);

    always @(posedge clk) begin
        if (!nReset)
            Q <= 1'b0;
        else if (L)
            Q <= R;
        else if (E)
            Q <= w;
        // No operation if both L and E are low; Q retains its value.
    end

    initial begin
        Q = 1'b0; // Initialize Q to 0
    end
endmodule