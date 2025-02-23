module TopModule
(
  input  logic clk,
  input  logic reset,
  input  logic in_,
  output logic done
);

  // State encoding

  typedef enum logic [2:0] {IDLE, START, DATA, STOP} state_t;

  // Sequential logic

  state_t current_state, next_state;
  logic [7:0] data;
  logic [2:0] bit_count;

  always @( posedge clk ) begin
    if ( reset ) begin
      current_state <= IDLE;
      data <= 0;
      bit_count <= 0;
    end
    else begin
      current_state <= next_state;
      if ( next_state == DATA ) begin
        data <= {data[6:0], in_};
        bit_count <= bit_count + 1;
      end
    end
  end

  // Combinational logic

  always @(*) begin
    done = 0;
    case ( current_state )
      IDLE: begin
        if ( in_ == 0 )
          next_state = START;
        else
          next_state = IDLE;
      end
      START: begin
        next_state = DATA;
      end
      DATA: begin
        if ( bit_count == 7 )
          next_state = STOP;
        else
          next_state = DATA;
      end
      STOP: begin
        if ( in_ == 1 ) begin
          next_state = IDLE;
          done = 1;
        end
        else
          next_state = STOP;
      end
    endcase
  end

endmodule