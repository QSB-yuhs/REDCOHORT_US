library(redCohort)
renv::restore()

# Maximum number of cores to be used:
maxCores <- parallel::detectCores()

# The folder where the study intermediate and result files will be written:
outputFolder <- "C:/REDCDM_US_TEST"

# Details for connecting to the server:
connectionDetails <-
        DatabaseConnector::createConnectionDetails(
                dbms = "sql server",
                server = "10.28.40.173",
                user = "ohdsi_app_user",
                password = "app1",
                port = "1433"
        )

# The name of the database schema where the CDM data can be found:
cdmDatabaseSchema <- "REDCDM_149work.dbo"

# The name of the database schema and table where the study-specific cohorts will be instantiated:
cohortDatabaseSchema <- "QSB.dbo"
cohortTable <- "REDCDM_US"

# Some meta-information that will be used by the export function:
databaseId <- "REDCDM"
databaseName <- "REDCDM"
databaseDescription <- "REDCDM"

# For Oracle: define a schema that can be used to emulate temp tables:
tempEmulationSchema <- NULL

redCohort::execute(
        connectionDetails = connectionDetails,
        cdmDatabaseSchema = cdmDatabaseSchema,
        cohortDatabaseSchema = cohortDatabaseSchema,
        cohortTable = cohortTable,
        tempEmulationSchema = tempEmulationSchema,
        outputFolder = outputFolder,
        databaseId = databaseId,
        databaseName = databaseName,
        databaseDescription = databaseDescription,
        minCellCount = 1
        
)


CohortDiagnostics::preMergeDiagnosticsFiles(dataFolder = outputFolder)
#shared file: c:/REDCDM/diagnosticsExport/Results_REDCDM.zip

CohortDiagnostics::launchDiagnosticsExplorer(dataFolder = outputFolder)

