using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.Data;
using System.Windows.Forms;
using System.Windows;
namespace cayquetdinh_Goiy
{
    public struct GainRatio
    {
        public double value;
        public Attribute at;

        public GainRatio(double value, Attribute at)
        {
            this.value = value;
            this.at = at;
        }


    }
    public class Attribute
    {
        ArrayList mValues;
        string mName;
        object mLabel;
       public string mlable;

        /// <summary>
        /// Inicializa uma nova instância de uma classe Atribute
        /// </summary>
        /// <param name="name">Indica o nome do atributo</param>
        /// <param name="values">Indica os valores possíveis para o atributo</param>
        public Attribute(string name, string[] values,String lb)
        {
            mName = name;
            mValues = new ArrayList(values);
            mValues.Sort();
            mlable = lb;
        }



        public Attribute(object Label)
        {
            mLabel = Label;
            mName = string.Empty;
            mValues = null;
        }

        /// <summary>
        /// Indica o nome do atributo
        /// </summary>
        public string AttributeName
        {
            get
            {
                return mName;
            }
        }

        /// <summary>
        /// Retorna um array com os valores do atributo
        /// </summary>
        public string[] values
        {
            get
            {
                if (mValues != null)
                    return (string[])mValues.ToArray(typeof(string));
                else
                    return null;
            }
        }

        /// <summary>
        /// Indica se um valor é permitido para este atributo
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        public bool isValidValue(string value)
        {
            return indexValue(value) >= 0;
        }

        /// <summary>
        /// Retorna o índice de um valor
        /// </summary>
        /// <param name="value">Valor a ser retornado</param>
        /// <returns>O valor do índice na qual a posição do valor se encontra</returns>
        public int indexValue(string value)
        {
            if (mValues != null)
                return mValues.BinarySearch(value);
            else
                return -1;
        }

        /// <summary>
        ///
        /// </summary>
        /// <returns></returns>
        public override string ToString()
        {
            if (mName != string.Empty)
            {
                return mName;
            }
            else
            {
                return mLabel.ToString();
            }
        }
    }
    class thuattoanC45
    {

        string SQL = null;
        DataTable tb_Mau;
        Attribute[] attributes;
        TreeNode Root;
        private int countTotalPositives(DataTable samples)
        {
            int result = 0;

            samples.DefaultView.RowFilter = "tinhhieuqua='Có'";
            result = samples.DefaultView.ToTable().Rows.Count;
            return result;
        }
        /// <summary>
        /// I(S) = -    -     = 0.970
        /// </summary>
        /// <returns></returns>
        private double Tinh_IS()
        {
            double S = tb_Mau.Rows.Count;
            tb_Mau.DefaultView.RowFilter = "tinhhieuqua='có'";
            double C = tb_Mau.DefaultView.ToTable().Rows.Count;

            double K = S - C;
            return (-(K / S) * System.Math.Log(K / S, 2)) - ((C / S) * System.Math.Log(C / S, 2));

        }
        /// <summary>
        /// Tinh Entropy
        /// </summary>
        /// <param name="at"></param>
        /// <returns></returns>
        public double calcEntropy(Attribute at)
        {
            double Entropy=0.0;
            double S = tb_Mau.Rows.Count;
            for (int i = 0; i < at.values.Length;i++ )
            {

                tb_Mau.DefaultView.RowFilter = "tinhhieuqua='Có' and " + at.AttributeName + "='" + at.values[i]+"'";
                double C = tb_Mau.DefaultView.ToTable().Rows.Count;
                tb_Mau.DefaultView.RowFilter = "tinhhieuqua='không' and " + at.AttributeName + "='" + at.values[i]+"'";
                double K = tb_Mau.DefaultView.ToTable().Rows.Count;
                Entropy += ((C+K)/S)* (((-C/(K+C))*System.Math.Log((C/(K+C)),2))-(((-K/(K+C))*System.Math.Log((K/(K+C)),2))));
            }
            return Entropy;
        }

        public double Gain(Attribute at)
        {
            return Tinh_IS() - calcEntropy(at);
        }

        public double SplitInfo(Attribute at)
        {double Split = 0.0;
            for (int i = 0; i < at.values.Length; i++)
            {

                tb_Mau.DefaultView.RowFilter = "tinhhieuqua='có' and " + at.AttributeName + "='" + at.values[i]+"'";
                double C = tb_Mau.DefaultView.ToTable().Rows.Count;
                tb_Mau.DefaultView.RowFilter = "tinhhieuqua='không' and " + at.AttributeName + "='" + at.values[i]+"'";
                double K = tb_Mau.DefaultView.ToTable().Rows.Count;
                double S = tb_Mau.Rows.Count;
                Split += (-(C + K) / S) * (((K + C) / S) * System.Math.Log(((K + C) / S), 2)) ;
            }
            return Split;
            }

        public double GainRation(Attribute at)
        {
            return Gain(at) / SplitInfo(at);
        }
        public thuattoanC45(DataTable  tb)
        {
            Treec45 = new TreeView();
            Treec45.Dock = DockStyle.Fill;
            TreeNode Root = new TreeNode();
            this.tb_Mau = tb;
            Attribute Gioitinh = new Attribute("Gioitinh", new string[] { "1", "2", "3" }, "Gioi tinh");
            Attribute tinhtrang = new Attribute("tinhtrang", new string[] { "1", "2", "3" }, "trình trạng");
            Attribute xuhuong = new Attribute("xuhuong", new string[] { "1", "2", "3" }, "xu hướng");
            attributes = new Attribute[] { Gioitinh, tinhtrang, xuhuong };
             getCay();


        }
        public ArrayList GetGainRatio(Attribute[] attributes)
        {
            ArrayList arr_GainRatio = new ArrayList(); ;
            for (int i = 0; i < attributes.Length; i++)
            {

                GainRatio  GR = new GainRatio(this.GainRation(attributes[i]), attributes[i]);
                arr_GainRatio.Add(GR);

            }
            for (int i = 0; i < arr_GainRatio.Count - 1; i++)
            {
                for (int j = i + 1; j < arr_GainRatio.Count; j++)
                {
                    if (((GainRatio)arr_GainRatio[j]).value > ((GainRatio)arr_GainRatio[i]).value)
                    {
                        GainRatio temp = (GainRatio)arr_GainRatio[i];
                        arr_GainRatio[i] = arr_GainRatio[j];
                        arr_GainRatio[j] = temp;

                    }
                }
            }
            return arr_GainRatio;
        }
        public void XMLTree()
        {


            ArrayList arr_GainRatio = new ArrayList(); ;


            arr_GainRatio = this.GetGainRatio(attributes);


            for (int i = 0; i < arr_GainRatio.Count; i++)
            {
                tb_Mau.DefaultView.RowFilter = "tinhhieuqua='có' and " + ((GainRatio)arr_GainRatio[0]).at.AttributeName + "='" + ((GainRatio)arr_GainRatio[0]).at.values[i]+"'";
                double C = tb_Mau.DefaultView.ToTable().Rows.Count;
                tb_Mau.DefaultView.RowFilter = "tinhhieuqua='không' and " + ((GainRatio)arr_GainRatio[0]).at.AttributeName + "='" + ((GainRatio)arr_GainRatio[0]).at.values[i]+"'";
                double K = tb_Mau.DefaultView.ToTable().Rows.Count;
                   }


        }

        public void RecursiveTree(DataTable tb, Node XML, ArrayList arr_GainRatio)
        {
            ArrayList arr_GainRatio1 = new ArrayList(); ;

            GainRatio GR;
            for (int i = 0; i < arr_GainRatio.Count; i++)
            {

                GR = new GainRatio(this.GainRation(((GainRatio)arr_GainRatio[i]).at), ((GainRatio)arr_GainRatio[i]).at);
                arr_GainRatio1.Add(GR);

            }
            for (int i = 0; i < arr_GainRatio.Count - 1; i++)
            {
                for (int j = i + 1; j < arr_GainRatio.Count; j++)
                {
                    if (((GainRatio)arr_GainRatio[j]).value > ((GainRatio)arr_GainRatio[i]).value)
                    {
                        GainRatio temp = (GainRatio)arr_GainRatio[i];
                        arr_GainRatio[i] = arr_GainRatio[j];
                        arr_GainRatio[j] = temp;

                    }
                }
            }

            if (arr_GainRatio.Count > 0)
            {


                for (int i = 0; i < arr_GainRatio.Count; i++)
                {
                    tb_Mau.DefaultView.RowFilter = "tinhhieuqua='có' and " + ((GainRatio)arr_GainRatio[0]).at.AttributeName + "='" + ((GainRatio)arr_GainRatio[0]).at.values[i]+"'";
                    double C = tb_Mau.DefaultView.ToTable().Rows.Count;
                    tb_Mau.DefaultView.RowFilter = "tinhhieuqua='không' and " + ((GainRatio)arr_GainRatio[0]).at.AttributeName + "='" + ((GainRatio)arr_GainRatio[0]).at.values[i]+"'";
                    double K = tb_Mau.DefaultView.ToTable().Rows.Count;

                    DataTable tb1 = tb_Mau.DefaultView.ToTable();

                    RecursiveTree(tb1, node_child, arr_GainRatio1);
                    arr_GainRatio1.RemoveAt(0);
                }

            }

        }



    }

}
