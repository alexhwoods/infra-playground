import Head from "next/head";
import Image from "next/image";
import styles from "../styles/Home.module.css";

export default function Home({ authorized }) {
  // console.log(`authorized: ${JSON.stringify(authorized, null, 2)}`);
  // const authorized = true;
  return (
    <div className={styles.container}>
      <Head>
        <title>Create Next App</title>
        <meta name="description" content="Generated by create next app" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      {authorized ? (
        <main className={styles.main}>
          <h1 className={styles.title}>Welcome, user</h1>

          <p className={styles.description}>
            Last year, your company made
            <code className={styles.code}>$43.28</code>. Spend wisely!
          </p>
        </main>
      ) : (
        <main className={styles.main}>
          <h1 className={styles.title}>
            Sorry, you do not have access to this information.
          </h1>
        </main>
      )}
    </div>
  );
}

export async function getServerSideProps(context) {
  const headers = context.req.headers;
  console.log(`host: ${JSON.stringify(headers, null, 2)}`);

  return {
    props: { authorized: true },
  };
}
