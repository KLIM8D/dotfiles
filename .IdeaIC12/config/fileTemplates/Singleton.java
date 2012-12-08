#if (${PACKAGE_NAME} && ${PACKAGE_NAME} != "")package ${PACKAGE_NAME};#end
#parse("File Header.java")
public class ${NAME}
{
    private static ${NAME} _instance;

    public static ${NAME} getInstance() 
    {
        return _instance != null ? _instance : (_instance = new ${NAME}());
    }

    private ${NAME}() 
    {
    }
}
