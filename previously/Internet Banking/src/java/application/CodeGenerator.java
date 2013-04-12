/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package application;

import java.util.Random;

/**
 *
 * @author Rahul
 */
public class CodeGenerator {

    private static Random code = new Random();
   public static int next()
    {
       return code.nextInt(10000);
   }

}
