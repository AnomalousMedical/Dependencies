using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CMakeHacks
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                int index = 0;
                switch(args[index++])
                {
                    case "replace":
                        String file = args[index++];
                        if (File.Exists(file))
                        {
                            String source = readStringFromCommandLine(args, ref index);
                            String replacement = readStringFromCommandLine(args, ref index);

                            replaceText(file, source, replacement);
                        }
                        else
                        {
                            String searchPattern = args[index++];

                            String source = readStringFromCommandLine(args, ref index);
                            String replacement = readStringFromCommandLine(args, ref index);

                            foreach (var fileName in Directory.EnumerateFiles(file, searchPattern, SearchOption.AllDirectories))
                            {
                                replaceText(fileName, source, replacement);
                            }
                        }
                        break;
                    default:
                        Console.WriteLine("Unknown Command. Please try the following:");
                        Console.WriteLine("replace file \"original text\" \"replacement text\"");
                        break;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(String.Format("A {0} occured modifying the file.\nMessage:{1}", ex.GetType().Name, ex.Message));
            }
        }

        private static String readStringFromCommandLine(String[] args, ref int index)
        {
            StringBuilder result = new StringBuilder();
            result.Append(args[index++]);
            if (result[0] == '"')
            {
                while (result[result.Length - 1] != '"')
                {
                    result.Append(args[index++]);
                }
            }
            if (result[0] == '"')
            {
                return result.ToString(1, result.Length - 2);
            }
            return result.ToString();
        }


        private static void replaceText(String file, String source, String replacement)
        {
            String text;
            using (StreamReader sr = new StreamReader(file))
            {
                text = sr.ReadToEnd();
            }

            text = text.Replace(source, replacement);

            using (StreamWriter sw = new StreamWriter(File.Open(file, FileMode.Create, FileAccess.ReadWrite, FileShare.None)))
            {
                sw.Write(text);
            }
        }
    }
}
