package osgiui.framework;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

public class Launcher
  implements BundleActivator
{
  private MainFrame _frame;

  public static void main( final String[] args )
  {
    final MainFrame frame = new MainFrame();
    frame.setVisible( true );
  }

  @Override
  public void start( final BundleContext bundleContext )
    throws Exception
  {
    _frame = new MainFrame();
    _frame.setVisible( true );
  }

  @Override
  public void stop( final BundleContext bundleContext )
    throws Exception
  {
    _frame.setVisible( false );
  }
}
