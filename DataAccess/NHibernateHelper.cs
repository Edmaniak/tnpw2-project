using System;
using System.IO;
using NHibernate;
using NHibernate.Cfg;

namespace DataAccess
{
    public class NHibernateHelper
    {
        private static ISessionFactory _factory;

        public static ISession Session
        {
            get
            {
                if (_factory == null)
                {
                    var cfg = new Configuration();
                    try
                    {
                        _factory = cfg
                            .Configure(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "hibernate.cfg.xml"))
                            .BuildSessionFactory();
                    }
                    catch (Exception e)
                    {
                        string m = e.Message;
                        Console.WriteLine(m);
                    }
                }

                return _factory.OpenSession();
            }
        }
    }
}