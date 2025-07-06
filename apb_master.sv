module apb_master (
    input  logic        PCLK,
    input  logic        PRESETn,
    output logic [31:0] PADDR,
    output logic        PSEL,
    output logic        PENABLE,
    output logic        PWRITE,
    output logic [31:0] PWDATA,
    input  logic [31:0] PRDATA,
    input  logic        PREADY,
    input  logic        PSLVERR
);

    typedef enum logic [1:0] {IDLE, SETUP, ENABLE} state_t;
    state_t state;

    logic [31:0] addr_reg, wdata_reg;
    logic        write_reg;
    logic [31:0] prdata_reg;
    logic        read_valid;

    always_ff @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            state      <= IDLE;
            PSEL       <= 0;
            PENABLE    <= 0;
            PWRITE     <= 0;
            addr_reg   <= 32'h0000_0004;
            wdata_reg  <= 32'hA5A5_5A5A;
            read_valid <= 0;
        end else begin
            case (state)
                IDLE: begin
                    PADDR   <= addr_reg;
                    PWDATA  <= wdata_reg;
                    PWRITE  <= 1;  // write first
                    PSEL    <= 1;
                    PENABLE <= 0;
                    state   <= SETUP;
                end
                SETUP: begin
                    PENABLE <= 1;
                    state   <= ENABLE;
                end
                ENABLE: begin
                    if (PREADY) begin
                        if (PWRITE) begin
                            // switch to read next
                            PWRITE <= 0;
                            PSEL   <= 1;
                            PENABLE <= 0;
                            state  <= SETUP;
                        end else begin
                            prdata_reg <= PRDATA;
                            read_valid <= 1;
                            PSEL    <= 0;
                            PENABLE <= 0;
                            state   <= IDLE;
                        end
                    end
                end
            endcase
        end
    end

    always_ff @(posedge PCLK) begin
        if (read_valid) begin
            $display("APB READ @ 0x%08h = 0x%08h", addr_reg, prdata_reg);
            read_valid <= 0;
        end
    end

endmodule