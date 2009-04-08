require File.dirname(__FILE__) + '/spec_helper.rb' 

describe "WSFE client" do 

  it "should take a sales input file with one record and convert it to a hash of items" do
    items = WSFE::Client.read_items_from_file(20238883890, false, File.dirname(__FILE__) + '/lote_ventas_1.txt')
    items.should == ITEMS_1_VENTAS
  end

  it "should take a services input file with one record and convert it to a hash of items" do
    items = WSFE::Client.read_items_from_file(20238883890, true, File.dirname(__FILE__) + '/lote_servicios_1.txt')
    items.should == ITEMS_1_SERVICIOS
  end

  it "should take a sales input file with many records and convert it to a hash of items" do
    items = WSFE::Client.read_items_from_file(20238883890, false, File.dirname(__FILE__) + '/lote_ventas.txt')
    items.should == ITEMS_VENTAS 
  end

  it "should take a services input file with many records and convert it to a hash of items" do
    items = WSFE::Client.read_items_from_file(20238883890, true, File.dirname(__FILE__) + '/lote_servicios.txt')
    items.should == ITEMS_SERVICIOS
  end

end

HOY = Time.now
VTO = Time.local(HOY.year, HOY.month == 12 ? 1 : HOY.month + 1, HOY.day)

ITEMS_1_VENTAS = [{
      :tipo_doc         => '80',
      :nro_doc          => '20238883890',
      :tipo_cbte        => '01',
      :punto_vta        => '0001',
      :cbt_desde        => '00000001',
      :cbt_hasta        => '00000001',
      :imp_total        => 1210.00,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 1000.00,
      :impto_liq        => 210.00,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '20081001',
      :fecha_serv_desde => HOY.strftime("%Y%m%d"),
      :fecha_serv_hasta => HOY.strftime("%Y%m%d"),
      :fecha_venc_pago  => VTO.strftime("%Y%m%d")
    }]

ITEMS_1_SERVICIOS = [{
      :tipo_doc         => '80',
      :nro_doc          => '20238883890',
      :tipo_cbte        => '01',
      :punto_vta        => '0001',
      :cbt_desde        => '00000001',
      :cbt_hasta        => '00000001',
      :imp_total        => 1210.00,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 1000.00,
      :impto_liq        => 210.00,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '20081001',
      :fecha_serv_desde => '20080901',
      :fecha_serv_hasta => '20080930',
      :fecha_venc_pago  => '20081015'
    }]

ITEMS_VENTAS = [
    {
      :tipo_doc         => '80',
      :nro_doc          => '30527777654',
      :tipo_cbte        => '01',
      :punto_vta        => '0001',
      :cbt_desde        => '00000395',
      :cbt_hasta        => '00000395',
      :imp_total        => 121.00,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 100.00,
      :impto_liq        => 21.00,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => HOY.strftime("%Y%m%d"),
      :fecha_serv_hasta => HOY.strftime("%Y%m%d"),
      :fecha_venc_pago  => VTO.strftime("%Y%m%d")
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '20083828855',
      :tipo_cbte        => '01',
      :punto_vta        => '0001',
      :cbt_desde        => '00000396',
      :cbt_hasta        => '00000396',
      :imp_total        => 72.60,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 60.00,
      :impto_liq        => 12.60,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => HOY.strftime("%Y%m%d"),
      :fecha_serv_hasta => HOY.strftime("%Y%m%d"),
      :fecha_venc_pago  => VTO.strftime("%Y%m%d")
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '30693531108',
      :tipo_cbte        => '02',
      :punto_vta        => '0001',
      :cbt_desde        => '00000350',
      :cbt_hasta        => '00000350',
      :imp_total        => 16.34,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 13.50,
      :impto_liq        => 2.84,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => HOY.strftime("%Y%m%d"),
      :fecha_serv_hasta => HOY.strftime("%Y%m%d"),
      :fecha_venc_pago  => VTO.strftime("%Y%m%d")
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '20120823028',
      :tipo_cbte        => '03',
      :punto_vta        => '0001',
      :cbt_desde        => '00000397',
      :cbt_hasta        => '00000397',
      :imp_total        => 163.35,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 135.00,
      :impto_liq        => 28.35,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => HOY.strftime("%Y%m%d"),
      :fecha_serv_hasta => HOY.strftime("%Y%m%d"),
      :fecha_venc_pago  => VTO.strftime("%Y%m%d")
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '30527777654',
      :tipo_cbte        => '03',
      :punto_vta        => '0001',
      :cbt_desde        => '00000398',
      :cbt_hasta        => '00000398',
      :imp_total        => 59.90,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 49.50,
      :impto_liq        => 10.40,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => HOY.strftime("%Y%m%d"),
      :fecha_serv_hasta => HOY.strftime("%Y%m%d"),
      :fecha_venc_pago  => VTO.strftime("%Y%m%d")
    }
    ]

ITEMS_SERVICIOS = [
    {
      :tipo_doc         => '80',
      :nro_doc          => '30527777654',
      :tipo_cbte        => '01',
      :punto_vta        => '0001',
      :cbt_desde        => '00000397',
      :cbt_hasta        => '00000397',
      :imp_total        => 199.65,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 165.00,
      :impto_liq        => 34.65,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '20080911',
      :fecha_serv_hasta => '20080911',
      :fecha_venc_pago  => '20080921'
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '30693531108',
      :tipo_cbte        => '01',
      :punto_vta        => '0001',
      :cbt_desde        => '00000398',
      :cbt_hasta        => '00000398',
      :imp_total        => 52.64,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 43.50,
      :impto_liq        => 9.14,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '20080911',
      :fecha_serv_hasta => '20080911',
      :fecha_venc_pago  => '20080921'
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '20083828855',
      :tipo_cbte        => '02',
      :punto_vta        => '0001',
      :cbt_desde        => '00000351',
      :cbt_hasta        => '00000351',
      :imp_total        => 79.86,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 66.00,
      :impto_liq        => 13.86,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '20080911',
      :fecha_serv_hasta => '20080911',
      :fecha_venc_pago  => '20080921'
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '30693531108',
      :tipo_cbte        => '02',
      :punto_vta        => '0001',
      :cbt_desde        => '00000352',
      :cbt_hasta        => '00000352',
      :imp_total        => 399.30,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 330.00,
      :impto_liq        => 69.30,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '20080911',
      :fecha_serv_hasta => '20080911',
      :fecha_venc_pago  => '20080921'
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '20083828855',
      :tipo_cbte        => '03',
      :punto_vta        => '0001',
      :cbt_desde        => '00000399',
      :cbt_hasta        => '00000399',
      :imp_total        => 84.70,
      :imp_tot_conc     => 0.0,
      :imp_neto         => 70.00,
      :impto_liq        => 14.70,
      :impto_liq_rni    => 0.0,
      :imp_op_ex        => 0.0,
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '20080911',
      :fecha_serv_hasta => '20080911',
      :fecha_venc_pago  => '20080921'
    }
    ]

