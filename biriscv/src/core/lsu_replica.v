// input external delay: 4 ns
// in delay: 0.011365 ns
// input delay: 0.010861 ns
// output delay: 0.175128 ns
// out delay: 0.000627 ns
// total extra delay: 4.197981 ns
// critical path time: 6.572384 ns
// total inverter delay needed: 6.572384 - 4.197981 = 2.374403 ns
// average one inverter delay: 0.03012 ns
// inverters needed: 76

module inverter(input wire a, output wire y);
    not (y, a);
endmodule

module lsu_replica(input wire in, output wire out);
	wire [74:0] interconnections; // Wires to connect inverters

	// Instantiate 72 inverters and chain them
	inverter inv0(in, interconnections[0]);
	inverter inv1(interconnections[0], interconnections[1]);
	inverter inv2(interconnections[1], interconnections[2]);
	inverter inv3(interconnections[2], interconnections[3]);
	inverter inv4(interconnections[3], interconnections[4]);
	inverter inv5(interconnections[4], interconnections[5]);
	inverter inv6(interconnections[5], interconnections[6]);
	inverter inv7(interconnections[6], interconnections[7]);
	inverter inv8(interconnections[7], interconnections[8]);
	inverter inv9(interconnections[8], interconnections[9]);
	inverter inv10(interconnections[9], interconnections[10]);
	inverter inv11(interconnections[10], interconnections[11]);
	inverter inv12(interconnections[11], interconnections[12]);
	inverter inv13(interconnections[12], interconnections[13]);
	inverter inv14(interconnections[13], interconnections[14]);
	inverter inv15(interconnections[14], interconnections[15]);
	inverter inv16(interconnections[15], interconnections[16]);
	inverter inv17(interconnections[16], interconnections[17]);
	inverter inv18(interconnections[17], interconnections[18]);
	inverter inv19(interconnections[18], interconnections[19]);
	inverter inv20(interconnections[19], interconnections[20]);
	inverter inv21(interconnections[20], interconnections[21]);
	inverter inv22(interconnections[21], interconnections[22]);
	inverter inv23(interconnections[22], interconnections[23]);
	inverter inv24(interconnections[23], interconnections[24]);
	inverter inv25(interconnections[24], interconnections[25]);
	inverter inv26(interconnections[25], interconnections[26]);
	inverter inv27(interconnections[26], interconnections[27]);
	inverter inv28(interconnections[27], interconnections[28]);
	inverter inv29(interconnections[28], interconnections[29]);
	inverter inv30(interconnections[29], interconnections[30]);
	inverter inv31(interconnections[30], interconnections[31]);
	inverter inv32(interconnections[31], interconnections[32]);
	inverter inv33(interconnections[32], interconnections[33]);
	inverter inv34(interconnections[33], interconnections[34]);
	inverter inv35(interconnections[34], interconnections[35]);
	inverter inv36(interconnections[35], interconnections[36]);
	inverter inv37(interconnections[36], interconnections[37]);
	inverter inv38(interconnections[37], interconnections[38]);
	inverter inv39(interconnections[38], interconnections[39]);
	inverter inv40(interconnections[39], interconnections[40]);
	inverter inv41(interconnections[40], interconnections[41]);
	inverter inv42(interconnections[41], interconnections[42]);
	inverter inv43(interconnections[42], interconnections[43]);
	inverter inv44(interconnections[43], interconnections[44]);
	inverter inv45(interconnections[44], interconnections[45]);
	inverter inv46(interconnections[45], interconnections[46]);
	inverter inv47(interconnections[46], interconnections[47]);
	inverter inv48(interconnections[47], interconnections[48]);
	inverter inv49(interconnections[48], interconnections[49]);
	inverter inv50(interconnections[49], interconnections[50]);
	inverter inv51(interconnections[50], interconnections[51]);
	inverter inv52(interconnections[51], interconnections[52]);
	inverter inv53(interconnections[52], interconnections[53]);
	inverter inv54(interconnections[53], interconnections[54]);
	inverter inv55(interconnections[54], interconnections[55]);
	inverter inv56(interconnections[55], interconnections[56]);
	inverter inv57(interconnections[56], interconnections[57]);
	inverter inv58(interconnections[57], interconnections[58]);
	inverter inv59(interconnections[58], interconnections[59]);
	inverter inv60(interconnections[59], interconnections[60]);
	inverter inv61(interconnections[60], interconnections[61]);
	inverter inv62(interconnections[61], interconnections[62]);
	inverter inv63(interconnections[62], interconnections[63]);
	inverter inv64(interconnections[63], interconnections[64]);
	inverter inv65(interconnections[64], interconnections[65]);
	inverter inv66(interconnections[65], interconnections[66]);
	inverter inv67(interconnections[66], interconnections[67]);
	inverter inv68(interconnections[67], interconnections[68]);
	inverter inv69(interconnections[68], interconnections[69]);
	inverter inv70(interconnections[69], interconnections[70]);
	inverter inv71(interconnections[70], interconnections[71]);
	inverter inv72(interconnections[71], interconnections[72]);
	inverter inv73(interconnections[72], interconnections[73]);
	inverter inv74(interconnections[73], interconnections[74]);
	inverter inv75(interconnections[74], out);
endmodule