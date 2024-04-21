// input external delay: 4 ns
// in delay: 0.011365 ns
// input delay: 0.010861 ns
// output delay: 0.175128 ns
// out delay: 0.000627 ns
// total extra delay: 4.197981 ns
// critical path time: 9.305513 ns
// total inverter delay needed: 9.305513 - 4.197981 = 5.107532 ns
// average one inverter delay: 0.03012 ns
// inverters needed: 164

module inverter(input wire a, output wire y);
    not (y, a);
endmodule

module exec_replica(input wire in, output wire out);
	wire [162:0] interconnections; // Wires to connect inverters

	// Instantiate 164 inverters and chain them
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
	inverter inv75(interconnections[74], interconnections[75]);
	inverter inv76(interconnections[75], interconnections[76]);
	inverter inv77(interconnections[76], interconnections[77]);
	inverter inv78(interconnections[77], interconnections[78]);
	inverter inv79(interconnections[78], interconnections[79]);
	inverter inv80(interconnections[79], interconnections[80]);
	inverter inv81(interconnections[80], interconnections[81]);
	inverter inv82(interconnections[81], interconnections[82]);
	inverter inv83(interconnections[82], interconnections[83]);
	inverter inv84(interconnections[83], interconnections[84]);
	inverter inv85(interconnections[84], interconnections[85]);
	inverter inv86(interconnections[85], interconnections[86]);
	inverter inv87(interconnections[86], interconnections[87]);
	inverter inv88(interconnections[87], interconnections[88]);
	inverter inv89(interconnections[88], interconnections[89]);
	inverter inv90(interconnections[89], interconnections[90]);
	inverter inv91(interconnections[90], interconnections[91]);
	inverter inv92(interconnections[91], interconnections[92]);
	inverter inv93(interconnections[92], interconnections[93]);
	inverter inv94(interconnections[93], interconnections[94]);
	inverter inv95(interconnections[94], interconnections[95]);
	inverter inv96(interconnections[95], interconnections[96]);
	inverter inv97(interconnections[96], interconnections[97]);
	inverter inv98(interconnections[97], interconnections[98]);
	inverter inv99(interconnections[98], interconnections[99]);
	inverter inv100(interconnections[99], interconnections[100]);
	inverter inv101(interconnections[100], interconnections[101]);
	inverter inv102(interconnections[101], interconnections[102]);
	inverter inv103(interconnections[102], interconnections[103]);
	inverter inv104(interconnections[103], interconnections[104]);
	inverter inv105(interconnections[104], interconnections[105]);
	inverter inv106(interconnections[105], interconnections[106]);
	inverter inv107(interconnections[106], interconnections[107]);
	inverter inv108(interconnections[107], interconnections[108]);
	inverter inv109(interconnections[108], interconnections[109]);
	inverter inv110(interconnections[109], interconnections[110]);
	inverter inv111(interconnections[110], interconnections[111]);
	inverter inv112(interconnections[111], interconnections[112]);
	inverter inv113(interconnections[112], interconnections[113]);
	inverter inv114(interconnections[113], interconnections[114]);
	inverter inv115(interconnections[114], interconnections[115]);
	inverter inv116(interconnections[115], interconnections[116]);
	inverter inv117(interconnections[116], interconnections[117]);
	inverter inv118(interconnections[117], interconnections[118]);
	inverter inv119(interconnections[118], interconnections[119]);
	inverter inv120(interconnections[119], interconnections[120]);
	inverter inv121(interconnections[120], interconnections[121]);
	inverter inv122(interconnections[121], interconnections[122]);
	inverter inv123(interconnections[122], interconnections[123]);
	inverter inv124(interconnections[123], interconnections[124]);
	inverter inv125(interconnections[124], interconnections[125]);
	inverter inv126(interconnections[125], interconnections[126]);
	inverter inv127(interconnections[126], interconnections[127]);
	inverter inv128(interconnections[127], interconnections[128]);
	inverter inv129(interconnections[128], interconnections[129]);
	inverter inv130(interconnections[129], interconnections[130]);
    inverter inv131(interconnections[130], interconnections[131]);
	inverter inv132(interconnections[131], interconnections[132]);
	inverter inv133(interconnections[132], interconnections[133]);
	inverter inv134(interconnections[133], interconnections[134]);
	inverter inv135(interconnections[134], interconnections[135]);
	inverter inv136(interconnections[135], interconnections[136]);
	inverter inv137(interconnections[136], interconnections[137]);
	inverter inv138(interconnections[137], interconnections[138]);
	inverter inv139(interconnections[138], interconnections[139]);
	inverter inv140(interconnections[139], interconnections[140]);
    inverter inv141(interconnections[140], interconnections[141]);
	inverter inv142(interconnections[141], interconnections[142]);
	inverter inv143(interconnections[142], interconnections[143]);
	inverter inv144(interconnections[143], interconnections[144]);
	inverter inv145(interconnections[144], interconnections[145]);
	inverter inv146(interconnections[145], interconnections[146]);
	inverter inv147(interconnections[146], interconnections[147]);
	inverter inv148(interconnections[147], interconnections[148]);
	inverter inv149(interconnections[148], interconnections[149]);
	inverter inv150(interconnections[149], interconnections[150]);
    inverter inv151(interconnections[150], interconnections[151]);
	inverter inv152(interconnections[151], interconnections[152]);
	inverter inv153(interconnections[152], interconnections[153]);
	inverter inv154(interconnections[153], interconnections[154]);
	inverter inv155(interconnections[154], interconnections[155]);
	inverter inv156(interconnections[155], interconnections[156]);
	inverter inv157(interconnections[156], interconnections[157]);
	inverter inv158(interconnections[157], interconnections[158]);
	inverter inv159(interconnections[158], interconnections[159]);
	inverter inv160(interconnections[159], interconnections[160]);
    inverter inv161(interconnections[160], interconnections[161]);
	inverter inv162(interconnections[161], interconnections[162]);
	inverter inv163(interconnections[162], out);
endmodule

