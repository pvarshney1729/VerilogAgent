module TopModule (
    input logic in,              // Single-bit input signal
    input logic [3:0] state,     // 4-bit one-hot encoded current state
    output logic [3:0] next_state, // 4-bit one-hot encoded next state
    output logic out             // Single-bit output signal
);

    // State Transition Logic
    assign next_state = (state == 4'b0001) ? (in ? 4'b0010 : 4'b0001) :
                        (state == 4'b0010) ? (in ? 4'b0010 : 4'b0100) :
                        (state == 4'b0100) ? (in ? 4'b1000 : 4'b0001) :
                        (state == 4'b1000) ? (in ? 4'b0010 : 4'b0100) : 4'b0000;

    // Output Logic
    assign out = (state == 4'b1000) ? 1'b1 : 1'b0;

endmodule