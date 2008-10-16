require File.dirname(__FILE__) + '/../lib/wsaaClient.rb'
require File.dirname(__FILE__) + '/../lib/wsfeClient.rb'

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

ITEMS_1_VENTAS = [{
      :tipo_doc         => '80',
      :nro_doc          => '20238883890',
      :tipo_cbte        => '01',
      :punto_vta        => '0001',
      :cbt_desde        => '00000001',
      :cbt_hasta        => '00000001',
      :imp_total        => '000000000121000',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000100000',
      :impto_liq        => '000000000021000',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
      :fecha_cbte       => '20081001',
      :fecha_serv_desde => '00000000',
      :fecha_serv_hasta => '00000000',
      :fecha_venc_pago  => '00000000'
    }]

ITEMS_1_SERVICIOS = [{
      :tipo_doc         => '80',
      :nro_doc          => '20238883890',
      :tipo_cbte        => '01',
      :punto_vta        => '0001',
      :cbt_desde        => '00000001',
      :cbt_hasta        => '00000001',
      :imp_total        => '000000000121000',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000100000',
      :impto_liq        => '000000000021000',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
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
      :imp_total        => '000000000012100',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000010000',
      :impto_liq        => '000000000002100',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '00000000',
      :fecha_serv_hasta => '00000000',
      :fecha_venc_pago  => '00000000'
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '20083828855',
      :tipo_cbte        => '01',
      :punto_vta        => '0001',
      :cbt_desde        => '00000396',
      :cbt_hasta        => '00000396',
      :imp_total        => '000000000007260',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000006000',
      :impto_liq        => '000000000001260',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '00000000',
      :fecha_serv_hasta => '00000000',
      :fecha_venc_pago  => '00000000'
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '30693531108',
      :tipo_cbte        => '02',
      :punto_vta        => '0001',
      :cbt_desde        => '00000350',
      :cbt_hasta        => '00000350',
      :imp_total        => '000000000001634',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000001350',
      :impto_liq        => '000000000000284',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '00000000',
      :fecha_serv_hasta => '00000000',
      :fecha_venc_pago  => '00000000'
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '20120823028',
      :tipo_cbte        => '03',
      :punto_vta        => '0001',
      :cbt_desde        => '00000397',
      :cbt_hasta        => '00000397',
      :imp_total        => '000000000016335',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000013500',
      :impto_liq        => '000000000002835',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '00000000',
      :fecha_serv_hasta => '00000000',
      :fecha_venc_pago  => '00000000'
    },
    {
      :tipo_doc         => '80',
      :nro_doc          => '30527777654',
      :tipo_cbte        => '03',
      :punto_vta        => '0001',
      :cbt_desde        => '00000398',
      :cbt_hasta        => '00000398',
      :imp_total        => '000000000005990',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000004950',
      :impto_liq        => '000000000001040',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '00000000',
      :fecha_serv_hasta => '00000000',
      :fecha_venc_pago  => '00000000'
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
      :imp_total        => '000000000019965',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000016500',
      :impto_liq        => '000000000003465',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
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
      :imp_total        => '000000000005264',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000004350',
      :impto_liq        => '000000000000914',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
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
      :imp_total        => '000000000007986',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000006600',
      :impto_liq        => '000000000001386',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
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
      :imp_total        => '000000000039930',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000033000',
      :impto_liq        => '000000000006930',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
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
      :imp_total        => '000000000008470',
      :imp_tot_conc     => '000000000000000',
      :imp_neto         => '000000000007000',
      :impto_liq        => '000000000001470',
      :impto_liq_rni    => '000000000000000',
      :imp_op_ex        => '000000000000000',
      :fecha_cbte       => '00000000',
      :fecha_serv_desde => '20080911',
      :fecha_serv_hasta => '20080911',
      :fecha_venc_pago  => '20080921'
    }
    ]

