import type {PostgresDb} from "@fastify/postgres";

type PgInfos = {
    size: number;
    numberOfConnexions: number;
    numberOfActiveConnexions: number;
    listOfAllPublicTables: string[];
}

export const getDatabaseInfos = (db: PostgresDb) => async (): Promise<PgInfos[] | Error>  => {
    const client = await db.connect();
    try {
        const [size, numberOfConnexions,
            numberOfActiveConnexions,
            listOfAllPublicTables] = await Promise.all([
            client.query(getDatabaseSize).rows,
        client.query(getDatabaseNumberOfConnections).rows,
        client.query(getDatabaseNumberOfActiveConnections).rows,
        client.query(listAllTableNames).rows,
        ])

        return {
            size,
            numberOfConnexions,
            numberOfActiveConnexions,
            listOfAllPublicTables
        };
    }
    catch (error: unknown) {
        return new Error((error as Error).message);
    } finally {
        client.release()
    }
}

export const getDatabaseSize: string = `
    SELECT pg_size_pretty(pg_database_size(current_database()));
    `;

export const getDatabaseNumberOfConnections: string = `
    SELECT COUNT(*) FROM pg_stat_activity WHERE datname = current_database();
    `;

export const getDatabaseNumberOfActiveConnections: string = `
    SELECT COUNT(*) FROM pg_stat_activity WHERE datname = current_database() AND state = 'active';
    `;

export const listAllTableNames: string = `
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'public';
    `;